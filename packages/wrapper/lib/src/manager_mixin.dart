import 'package:wrapper/src/client.dart';
import 'package:wrapper/src/client_options.dart';
import 'package:wrapper/src/http/managers/club_manager.dart';
import 'package:wrapper/src/http/managers/conversation_manager.dart';
import 'package:wrapper/src/http/managers/job_manager.dart';
import 'package:wrapper/src/http/managers/message_manager.dart';
import 'package:wrapper/src/http/managers/school_manager.dart';
import 'package:wrapper/src/http/managers/company_manager.dart';
import 'package:wrapper/src/http/managers/story_manager.dart';
import 'package:wrapper/src/http/managers/user_manager.dart';

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

  JobManager get jobs =>
      JobManager(options.jobCacheConfig, this as WrapperRest);

  StoryManager get stories =>
      StoryManager(options.storyCacheConfig, this as WrapperRest);

  ConversationManager get conversations =>
      ConversationManager(options.conversationCacheConfig, this as WrapperRest);
}
