import 'dart:async';
import 'package:universal_io/io.dart';

import 'package:wrapper/src/client.dart';
import 'package:wrapper/src/plugin/plugin.dart';

/// A global instance of the [CliIntegration] plugin.
final cliIntegration = CliIntegration();

/// A plugin that lets clients close their session gracefully when the process is terminated.
class CliIntegration extends WrapperPlugin {
  @override
  String get name => 'CliIntegration';

  final Set<Wrapper> _watchedClients = {};
  List<StreamSubscription<ProcessSignal>>? _subscriptions;

  void _ensureListening() {
    void closeClients(ProcessSignal signal) async {
      await Future.wait(
        Set.of(_watchedClients).map((client) {
          client.logger.info('Caught SIGINT or SIGTERM, closing');
          return client.close();
        }),
      );

      // Our listeners will have been removed, send the signal again to either terminate the process or let
      // other signal handlers handle it.
      // This will end up calling other signal handlers twice.
      Process.killPid(pid, signal);
    }

    _subscriptions ??= [
      ProcessSignal.sigint.watch().listen(closeClients),
      if (!Platform.isWindows)
        ProcessSignal.sigterm.watch().listen(closeClients),
    ];
  }

  void _removeListenersIfNeeded() {
    if (_subscriptions == null || _watchedClients.isNotEmpty) {
      return;
    }

    for (final subscription in _subscriptions!) {
      subscription.cancel();
    }
    _subscriptions = null;
  }

  @override
  void afterConnect(Wrapper client) {
    _ensureListening();

    _watchedClients.add(client);
    client.logger.info('Listening for SIGINT or SIGTERM to safely close');
  }

  @override
  void beforeClose(Wrapper client) {
    _watchedClients.remove(client);
    _removeListenersIfNeeded();
  }
}
