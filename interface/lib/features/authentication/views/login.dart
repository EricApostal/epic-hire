import 'package:epic_hire/features/authentication/components/login_box.dart';
import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:epic_hire/shared/components/buttons/styled_text_button.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              MediaQuery.of(context).padding.top + 16,
              16,
              MediaQuery.of(context).padding.bottom + 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/epic-hire-banner.svg",
                  height: 90,
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login to Epic Hire",
                          style: Theme.of(context).custom.textTheme.titleLarge,
                        ),
                        Text(
                          "We're happy to have you back!",
                          style: Theme.of(context).custom.textTheme.subtitle1,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                LoginBox(
                  hintText: "Email",
                  controller: usernameController,
                  autofillHints: ["email", "username"],
                  obscureText: false,
                ),
                const SizedBox(height: 12),
                LoginBox(
                  hintText: "Password",
                  controller: passwordController,
                  autofillHints: ["password"],
                  obscureText: true,
                ),
                Spacer(),
                StyledTextButton(
                  "Submit",
                  callback: () async {
                    final resp = await ref
                        .read(authenticationProvider.notifier)
                        .login(
                          usernameController.text,
                          passwordController.text,
                        );
                    GoRouter.of(context).go("/home");
                  },
                  backgroundColor: Theme.of(context).custom.colorTheme.primary,
                ),
                const SizedBox(height: 12),
                StyledTextButton(
                  "Continue as Guest",
                  callback: () async {
                    await ref
                        .read(authenticationProvider.notifier)
                        .loginAsGuest();
                    GoRouter.of(context).go("/home");
                  },
                  backgroundColor:
                      Theme.of(context).custom.colorTheme.foreground,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
