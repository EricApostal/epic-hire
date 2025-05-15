import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:epic_hire/features/user/repositories/user.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:http/http.dart' as http;

part 'resume.g.dart';

@riverpod
class UserResume extends _$UserResume {
  @override
  Future<Uint8List?> build(int userId) async {
    final user = ref.watch(epicUserProvider(userId)).valueOrNull;
    final auth = ref.watch(authenticationProvider).valueOrNull;
    if (user?.resumeKey == null || auth == null) return null;
    final response = await http.get(
      Uri.parse("https://api.epichire.com/v1/documents/${user!.resumeKey!}"),
      headers: {"authorization": auth.apiOptions.authorizationHeader!},
    );

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      return null;
    }
  }
}
