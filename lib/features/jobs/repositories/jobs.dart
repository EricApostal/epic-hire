import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wrapper/wrapper.dart';

part 'jobs.g.dart';

@Riverpod(keepAlive: true)
class Jobs extends _$Jobs {
  @override
  Future<List<Job>?> build() async {
    final auth = ref.watch(authenticationProvider).valueOrNull;
    if (auth == null) return null;

    return await auth.jobs.fetchJobListings(page: 0, limit: 20);
  }
}
