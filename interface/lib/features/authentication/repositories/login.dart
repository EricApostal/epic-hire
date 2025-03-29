import 'dart:convert';

import 'package:epic_hire/features/authentication/models/authenticated_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:wrapper/wrapper.dart';
import 'package:http/http.dart' as http;

part 'login.g.dart';

@Riverpod(keepAlive: true)
class Login extends _$Login {
  @override
  Future<WrapperRest?> build() async {
    return null;
  }

  Future<WrapperRest?> login(String username, String password) async {
    final Uri loginUri = Uri.parse("https://api.epichire.com/v2/auth/login");
    final deviceId = Uuid().v1();

    final requestBody = jsonEncode({
      "deviceId": deviceId,
      "username": username,
      "password": password,
    });
    final response = await http.post(
      loginUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: requestBody,
    );

    if (response.statusCode != 200) {
      throw Exception("Error logging in to Epic Hire.");
    }

    final body = jsonDecode(response.body);

    final user = AuthenticatedUser(
      token: body["token"],
      type: body["type"],
      refreshToken: body["refreshToken"],
      id: body["id"],
      username: body["username"],
      email: body["email"],
      role: body["role"],
      permissions: body["permissions"],
      companyPageIds: body["companyPageIds"],
      accountStatus: body["accountStatus"],
    );
    return await Wrapper.connectRest("Bearer ${user.token}");
  }
}
