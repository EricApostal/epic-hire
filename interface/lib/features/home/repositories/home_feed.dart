import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wrapper/wrapper.dart';

part 'home_feed.g.dart';

@Riverpod(keepAlive: true)
class HomeFeed extends _$HomeFeed {
  @override
  Future<List<Story>?> build() async {
    final auth = ref.watch(authenticationProvider).valueOrNull;
    if (auth == null) return null;

    return await auth.users.fetchHomePage();
  }
}
