import 'dart:async';

import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:runtime_type/runtime_type.dart';
import 'package:wrapper/src/client_options.dart';
import 'package:wrapper/src/http/handler.dart';
import 'package:wrapper/src/manager_mixin.dart';
import 'package:wrapper/src/models/user/user.dart';
import 'package:wrapper/src/plugin/plugin.dart';
import 'package:wrapper/src/api_options.dart';
import 'package:wrapper/src/errors.dart';

/// A helper function to nest and execute calls to plugin connect methods.
Future<T> _doConnect<T extends Wrapper>(
  ApiOptions apiOptions,
  ClientOptions clientOptions,
  Future<T> Function() connect,
  List<WrapperPlugin> plugins,
) {
  final actualClientType = RuntimeType<T>();

  for (final plugin in plugins) {
    if (!actualClientType.isSubtypeOf(plugin.clientType)) {
      throw PluginError(
        'Unsupported client type: plugin needs ${plugin.clientType.internalType}, client was ${actualClientType.internalType}',
      );
    }
  }

  final originalConnect = connect;

  connect = plugins.fold(
    () async =>
        await originalConnect()
          .._initializedCompleter.complete(),
    (previousConnect, plugin) =>
        () async => actualClientType.castInstance(
          await plugin.doConnect(apiOptions, clientOptions, previousConnect),
        ),
  );

  return connect();
}

/// A helper function to nest and execute calls to plugin close methods.
Future<void> _doClose(
  Wrapper client,
  Future<void> Function() close,
  List<WrapperPlugin> plugins,
) {
  close = plugins.fold(
    close,
    (previousClose, plugin) => () => plugin.doClose(client, previousClose),
  );
  return close();
}

@internal
extension InternalReady on Wrapper {
  /// A future that completes when this client is initialized and can be passed to user defined callbacks.
  @internal
  Future<void> get initialized => _initializedCompleter.future;
}

/// The base class for clients interacting with the Epic Hire API.
abstract class Wrapper {
  /// The options this client will use when connecting to the API.
  ApiOptions get apiOptions;

  /// The [HttpHandler] used by this client to make requests.
  HttpHandler get httpHandler;

  /// The options controlling the behavior of this client.
  ClientOptions get options;

  /// The logger for this client.
  Logger get logger;

  Completer<void> get _initializedCompleter;

  /// Create an instance of [WrapperRest] that can perform requests to the HTTP API and is
  /// authenticated with a bot token.
  static Future<WrapperRest> connectRest({
    int? userId,
    String? token,
    RestClientOptions options = const RestClientOptions(),
  }) => connectRestWithOptions(
    RestApiOptions(token: token, userId: userId),
    options,
  );

  /// Create an instance of [WrapperRest] using the provided options.
  static Future<WrapperRest> connectRestWithOptions(
    RestApiOptions apiOptions, [
    RestClientOptions clientOptions = const RestClientOptions(),
  ]) async {
    assert(
      ((apiOptions.token == null && apiOptions.userId == null) ||
          (apiOptions.token != null && apiOptions.userId != null)),
      "User ID and token must be provided together!",
    );

    clientOptions.logger
      ..info('Connecting to the REST API')
      ..fine(
        'Token: ${apiOptions.token}, Authorization: ${apiOptions.authorizationHeader}, User-Agent: ${apiOptions.userAgent}',
      )
      ..fine(
        'Plugins: ${clientOptions.plugins.map((plugin) => plugin.name).join(', ')}',
      );

    return _doConnect(apiOptions, clientOptions, () async {
      final client = WrapperRest._(apiOptions, clientOptions);

      if (apiOptions.token != null) {
        return client.._user = await client.users.fetchCurrentUser();
      } else {
        client._user = null;
      }

      return client;
    }, clientOptions.plugins);
  }

  /// Close this client and any underlying resources.
  ///
  /// The client should not be used after this is called and unexpected behavior may occur.
  Future<void> close();
}

/// A client that can make requests to the HTTP API and is authenticated with a token.
class WrapperRest with ManagerMixin implements Wrapper {
  @override
  final RestApiOptions apiOptions;

  @override
  final RestClientOptions options;

  @override
  late final HttpHandler httpHandler = HttpHandler(this);

  @override
  Logger get logger => options.logger;

  @override
  final Completer<void> _initializedCompleter = Completer();

  PartialUser? get user => _user;
  late PartialUser? _user;

  WrapperRest._(this.apiOptions, this.options);

  @override
  Future<void> close() {
    logger.info('Closing client');
    return _doClose(this, () async => httpHandler.close(), options.plugins);
  }
}
