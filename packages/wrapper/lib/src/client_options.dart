import 'package:wrapper/src/cache/cache.dart';
import 'package:wrapper/src/models/club/club.dart';
import 'package:wrapper/src/models/conversation/conversation.dart';
import 'package:wrapper/src/models/job/job.dart';
import 'package:wrapper/src/models/school/school.dart';
import 'package:wrapper/src/models/company/company.dart';
import 'package:wrapper/src/models/story/story.dart';
import 'package:wrapper/src/models/user/user.dart';
import 'package:wrapper/src/plugin/plugin.dart';
import 'package:logging/logging.dart';

/// Options for controlling the behavior of a [Wrapper] client.
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

/// Options for controlling the behavior of a [WrapperRest] client.
class RestClientOptions extends ClientOptions {
  /// The [CacheConfig] to use for the cache of the [WrapperRest.users] manager.
  final CacheConfig<User> userCacheConfig;

  /// The [CacheConfig] to use for the cache of the [WrapperRest.companies] manager.
  final CacheConfig<Company> companyCacheConfig;

  /// The [CacheConfig] to use for the cache of the [WrapperRest.schools] manager.
  final CacheConfig<School> schoolCacheConfig;

  /// The [CacheConfig] to use for the cache of the [WrapperRest.clubs] manager.
  final CacheConfig<Club> clubCacheConfig;

  /// The [CacheConfig] to use for the cache of the [WrapperRest.jobs] manager.
  final CacheConfig<Job> jobCacheConfig;

  /// The [CacheConfig] to use for the cache of the [WrapperRest.stories] manager.
  final CacheConfig<Story> storyCacheConfig;

  /// The [CacheConfig] to use for the cache of the [WrapperRest.conversations] manager.
  final CacheConfig<Conversation> conversationCacheConfig;

  /// Create a new [RestClientOptions].
  const RestClientOptions({
    super.plugins,
    super.loggerName,
    this.userCacheConfig = const CacheConfig(),
    this.companyCacheConfig = const CacheConfig(),
    this.schoolCacheConfig = const CacheConfig(),
    this.clubCacheConfig = const CacheConfig(),
    this.jobCacheConfig = const CacheConfig(),
    this.storyCacheConfig = const CacheConfig(),
    this.conversationCacheConfig = const CacheConfig(),
  });
}

/// Options for controlling the behavior of a [Wrapper] client.
class WrapperClientOptions extends RestClientOptions {
  /// Create a new [GatewayClientOptions].
  const WrapperClientOptions({super.plugins, super.loggerName});
}
