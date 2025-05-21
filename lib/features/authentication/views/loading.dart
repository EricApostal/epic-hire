import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce/hive.dart';

class StartupLoadingScreen extends ConsumerStatefulWidget {
  const StartupLoadingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StartupLoadingScreenState();
}

class _StartupLoadingScreenState extends ConsumerState<StartupLoadingScreen> {
  bool authenticated = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_tryLogin);

    super.initState();
  }

  _tryLogin(Duration dt) {
    try {
      final box = Hive.box("session");
      final String token = box.get("token");
      final int userId = box.get("user-id");
      ref.read(authenticationProvider.notifier).loginWithToken(token, userId);

      setState(() {
        authenticated = true;
      });
      context.go("/messages");
    } catch (e) {
      context.go("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator.adaptive());
  }
}
