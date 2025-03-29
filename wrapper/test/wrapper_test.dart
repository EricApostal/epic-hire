import 'package:flutter_test/flutter_test.dart';

import 'package:wrapper/wrapper.dart';

void main() {
  test('connect to the client', () async {
    final client = await Wrapper.connectRest(
      '',
      options: GatewayClientOptions(
        plugins: [Logging(logLevel: Level.ALL), cliIntegration],
      ),
    );

    print((await client.user.get()));
  });
}
