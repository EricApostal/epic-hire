import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'posts.g.dart';

@Riverpod(keepAlive: true)
class Posts extends _$Posts {
  @override
  Future<void> build() async {
    final auth = ref.watch(authenticationProvider).valueOrNull;
    if (auth == null) return;
  }
}
