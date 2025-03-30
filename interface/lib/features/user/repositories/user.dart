import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wrapper/wrapper.dart';

part 'user.g.dart';

@riverpod
class EpicUser extends _$EpicUser {
  @override
  Future<User?> build(int userId) async {
    final auth = ref.watch(authenticationProvider).valueOrNull;
    if (auth == null) return null;

    return auth.users.get(Identified(userId));
  }
}
