import 'package:flutter_test/flutter_test.dart';
import 'package:wrapper/src/client_options.dart';

import 'package:wrapper/wrapper.dart';

void main() async {
  test('connect to the client', () async {
    final client = await Wrapper.connectRest(
      userId: 20256,
      token: "",
      options: WrapperClientOptions(
        plugins: [
          Logging(logLevel: Level.ALL),
          cliIntegration,
        ],
      ),
    );

    assert(
      (await client.conversations.fetchConversationPages()).isNotEmpty,
      "Conversation pages did not fetch correctly!",
    );
  });

  // final client = await Wrapper.connectRest(
  //   options: WrapperClientOptions(
  //     plugins: [
  //       Logging(logLevel: Level.ALL),
  //       cliIntegration,
  //     ],
  //   ),
  // );

  // test('list conversations', () async {
  //   assert(
  //     (await client.conversations.fetchConversationPages()).isNotEmpty,
  //     "Company pages did not fetch correctly!",
  //   );
  // });

  // test('list company pages', () async {
  //   assert(
  //     (await client.companies.fetchCompanyPages()).isNotEmpty,
  //     "Company pages did not fetch correctly!",
  //   );
  // });

  // test('list club pages', () async {
  //   assert(
  //     (await client.clubs.fetchPage(1, limit: 20)).isNotEmpty,
  //     "Club pages did not fetch correctly!",
  //   );
  // });
}
