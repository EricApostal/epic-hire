import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wrapper/wrapper.dart';

part 'clubs.g.dart';

@Riverpod(keepAlive: true)
class Clubs extends _$Clubs {
  final List<Club> _allClubs = [];
  int currentPage = 0;
  WrapperRest? client;

  @override
  Future<List<Club>?> build() async {
    final _auth = ref.watch(authenticationProvider).valueOrNull;
    if (_auth == null) return null;

    client = _auth;

    return await client!.clubs.fetchPage(0, limit: 10);
  }

  Future<void> getNextPage() async {
    state = const AsyncLoading<List<Club>>();
    currentPage++;

    final newClubs = await client!.clubs.fetchPage(currentPage, limit: 10);
    _allClubs.addAll(newClubs);
    state = AsyncData(_allClubs);
  }
}
