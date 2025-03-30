import 'package:wrapper/src/cache/cache.dart';
import 'package:wrapper/src/models/club/club.dart';
import 'package:wrapper/src/models/job/job.dart';
import 'package:wrapper/src/models/school/school.dart';
import 'package:wrapper/src/models/company/company.dart';
import 'package:wrapper/src/models/user/user.dart';
import 'package:wrapper/src/plugin/plugin.dart';
import 'package:logging/logging.dart';

/// Options for controlling the behavior of a [Nyxx] client.
abstract class ClientOptions {
  /// The plugins to use for this client.
  final List<WrapperPlugin> plugins;

  /// The name of the logger to use for this client.
  final String loggerName;

  /// The logger to use for this client.
  Logger get logger => Logger(loggerName);

  /// Create a new [ClientOptions].
  const ClientOptions({this.plugins = const [], this.loggerName = 'Wrapper'});
}

/// Options for controlling the behavior of a [NyxxRest] client.
class RestClientOptions extends ClientOptions {
  /// The [CacheConfig] to use for the cache of the [NyxxRest.users] manager.
  final CacheConfig<User> userCacheConfig;

  /// The [CacheConfig] to use for the cache of the [NyxxRest.companies] manager.
  final CacheConfig<Company> companyCacheConfig;

  /// The [CacheConfig] to use for the cache of the [NyxxRest.schools] manager.
  final CacheConfig<School> schoolCacheConfig;

  /// The [CacheConfig] to use for the cache of the [NyxxRest.clubs] manager.
  final CacheConfig<Club> clubCacheConfig;

  /// The [CacheConfig] to use for the cache of the [NyxxRest.jobs] manager.
  final CacheConfig<Job> jobCacheConfig;

  /// Create a new [RestClientOptions].
  const RestClientOptions({
    super.plugins,
    super.loggerName,
    this.userCacheConfig = const CacheConfig(),
    this.companyCacheConfig = const CacheConfig(),
    this.schoolCacheConfig = const CacheConfig(),
    this.clubCacheConfig = const CacheConfig(),
    this.jobCacheConfig = const CacheConfig(),
  });
}

/// Options for controlling the behavior of a [NyxxGateway] client.
class GatewayClientOptions extends RestClientOptions {
  /// The minimum number of session starts this client needs to connect.
  ///
  /// This is a safety feature to avoid API bans due to excessive connection starts.
  ///
  /// If the remaining number of session starts is below this number, an error will be thrown when connecting.
  final int minimumSessionStarts;

  /// Create a new [GatewayClientOptions].
  const GatewayClientOptions({
    this.minimumSessionStarts = 10,
    super.plugins,
    super.loggerName,
  });
}
