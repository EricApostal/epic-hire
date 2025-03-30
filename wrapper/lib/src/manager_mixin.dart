import 'package:wrapper/src/client.dart';
import 'package:wrapper/src/client_options.dart';
import 'package:wrapper/src/http/managers/club_manager.dart';
import 'package:wrapper/src/http/managers/school_manager.dart';
import 'package:wrapper/src/http/managers/company_manager.dart';
import 'package:wrapper/src/http/managers/user_manager.dart';
import 'package:wrapper/src/models/club/school.dart';

/// An internal mixin to add managers to a [Wrapper] instance.
mixin ManagerMixin implements Wrapper {
  @override
  RestClientOptions get options;

  /// A [UserManager] that manages users for this client.
  UserManager get users =>
      UserManager(options.userCacheConfig, this as WrapperRest);

  CompanyManager get companies =>
      CompanyManager(options.companyCacheConfig, this as WrapperRest);

  SchoolManager get schools =>
      SchoolManager(options.schoolCacheConfig, this as WrapperRest);

  ClubManager get clubs =>
      ClubManager(options.clubCacheConfig, this as WrapperRest);

  // /// A [ChannelManager] that manages channels for this client.
  // ChannelManager get channels =>
  //     ChannelManager(options.channelCacheConfig, this as WrapperRest);

  // /// A [GuildManager] that manages guilds for this client.
  // GuildManager get guilds =>
  //     GuildManager(options.guildCacheConfig, this as WrapperRest);

  // /// An [InviteManager] that manages invites for this client.
  // InviteManager get invites => InviteManager(this as WrapperRest);

  // /// A [GatewayManager] that manages gateway metadata for this client.
  // GatewayManager get gateway => GatewayManager(this as WrapperRest);
}
