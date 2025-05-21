import 'package:chiclet/chiclet.dart';
import 'package:epic_hire/features/authentication/components/login_box.dart';
import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:epic_hire/shared/utils/platform.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = EpicHireTheme.of(context);
    return Container(
      decoration: BoxDecoration(color: EpicHireTheme.of(context).background),
      child: Center(
        child: ConstrainedBox(
          constraints: shouldUseDesktopLayout(context)
              ? BoxConstraints(maxWidth: 400)
              : BoxConstraints(),
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
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
                            style: Theme.of(context).textTheme.displayLarge!
                                .copyWith(
                                  fontFamily: GoogleFonts.outfit().fontFamily,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "We're happy to have you back!",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .copyWith(
                                  fontFamily: GoogleFonts.outfit().fontFamily,
                                  fontWeight: FontWeight.w900,
                                  color: theme.lightGray,
                                ),
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.gray, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    child: Column(
                      children: [
                        LoginBox(
                          hintText: "Email",
                          controller: usernameController,
                          autofillHints: ["email", "username"],
                          obscureText: false,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 2,
                          color: theme.gray,
                        ),
                        // const SizedBox(height: 12),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            LoginBox(
                              hintText: "Password",
                              controller: passwordController,
                              autofillHints: ["password"],
                              obscureText: hidePassword,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(18),
                                bottomRight: Radius.circular(18),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                color: theme.gray,
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  (shouldUseMobileLayout(context))
                      ? Spacer()
                      : const SizedBox(height: 48),
                  ChicletOutlinedAnimatedButton(
                    width: double.infinity,
                    onPressed: () async {
                      HapticFeedback.mediumImpact();
                      final _ = await ref
                          .read(authenticationProvider.notifier)
                          .login(
                            usernameController.text,
                            passwordController.text,
                            persist: true,
                          );
                      GoRouter.of(context).go("/messages");
                    },
                    backgroundColor: EpicHireTheme.of(context).blue,
                    borderColor: EpicHireTheme.of(
                      context,
                    ).blue.withValues(alpha: 0.7),
                    child: Text(
                      "Submit",
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge!.copyWith(color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 12),

                  ChicletOutlinedAnimatedButton(
                    width: double.infinity,
                    onPressed: () async {
                      HapticFeedback.lightImpact();
                      await ref
                          .read(authenticationProvider.notifier)
                          .loginAsGuest();
                      GoRouter.of(context).go("/messages");
                    },
                    backgroundColor: theme.dirtyWhite,
                    borderColor: theme.dirtyWhite.withValues(alpha: 0.7),
                    child: Text(
                      "Forgot Password",
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge!.copyWith(color: theme.background),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
