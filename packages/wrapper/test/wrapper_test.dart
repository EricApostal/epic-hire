import 'package:flutter_test/flutter_test.dart';
import 'package:wrapper/src/client_options.dart';

import 'package:wrapper/wrapper.dart';

void main() async {
  // test('connect to the client', () async {
  //   final client = await Wrapper.connectRest(
  //     '',
  //     options: WrapperClientOptions(
  //       plugins: [Logging(logLevel: Level.ALL), cliIntegration],
  //     ),
  //   );

  //   print((await client.user.get()));
  // });

  final client = await Wrapper.connectRest(
    options: WrapperClientOptions(
      plugins: [Logging(logLevel: Level.ALL), cliIntegration],
    ),
  );

  test('list company pages', () async {
    assert(
      (await client.companies.fetchCompanyPages()).isNotEmpty,
      "Company pages did not fetch correctly!",
    );
  });

  test('list club pages', () async {
    assert(
      (await client.clubs.fetchPage(1, limit: 20)).isNotEmpty,
      "Club pages did not fetch correctly!",
    );
  });
}
