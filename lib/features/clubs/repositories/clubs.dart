import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wrapper/wrapper.dart';

part 'clubs.g.dart';

@Riverpod(keepAlive: true)
class Clubs extends _$Clubs {
  final List<Club> _allClubs = [];
  int currentPage = 0;
  WrapperRest? auth;

  @override
  Future<List<Club>?> build() async {
    final _auth = ref.watch(authenticationProvider).valueOrNull;
    if (_auth == null) return null;

    auth = _auth;

    return await auth!.clubs.fetchPage(0, limit: 10);
  }

  Future<void> getNextPage() async {
    state = const AsyncLoading<List<Club>>();
    currentPage++;

    final newClubs = await auth!.clubs.fetchPage(currentPage, limit: 10);
    _allClubs.addAll(newClubs);
    state = AsyncData(_allClubs);
  }
}
