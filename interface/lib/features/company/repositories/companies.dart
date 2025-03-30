import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wrapper/wrapper.dart';

part 'companies.g.dart';

@Riverpod(keepAlive: true)
class Companies extends _$Companies {
  @override
  Future<List<Company>?> build() async {
    final auth = ref.watch(authenticationProvider).valueOrNull;
    print("auth null");
    if (auth == null) return null;
    print("fetching");

    return await auth.companies.fetchCompanyPages();
  }
}
