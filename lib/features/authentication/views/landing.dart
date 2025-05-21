import 'package:chiclet/chiclet.dart';
import 'package:epic_hire/features/authentication/repositories/login.dart';
import 'package:epic_hire/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = EpicHireTheme.of(context);
    final padding = MediaQuery.paddingOf(context);

    return Padding(
      padding: EdgeInsets.only(
        top: padding.top + 12,
        bottom: padding.bottom + 12,
        left: padding.left + 12,
        right: padding.right + 12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/epic-hire-banner.svg",
                  height: 90,
                ),
                const SizedBox(height: 24),
                Text(
                  "We're happy to have you back!",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: theme.lightGray,
                  ),
                ),
              ],
            ),
          ),

          Column(
            children: [
              ChicletOutlinedAnimatedButton(
                width: double.infinity,
                onPressed: () async {
                  HapticFeedback.lightImpact();
                  await ref
                      .read(authenticationProvider.notifier)
                      .loginAsGuest();
                  GoRouter.of(context).go("/messages");
                },
                backgroundColor: EpicHireTheme.of(context).blue,
                borderColor: EpicHireTheme.of(
                  context,
                ).blue.withValues(alpha: 0.7),
                child: Text(
                  "Register",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              ChicletOutlinedAnimatedButton(
                width: double.infinity,
                onPressed: () async {
                  HapticFeedback.lightImpact();
                  context.go("/login/existing");
                },
                backgroundColor: theme.dirtyWhite,
                borderColor: theme.dirtyWhite.withValues(alpha: 0.7),
                child: Text(
                  "Login",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: theme.background),
                ),
              ),
              const SizedBox(height: 8),
              ChicletOutlinedAnimatedButton(
                width: double.infinity,
                onPressed: () async {
                  HapticFeedback.lightImpact();
                  context.go("/messages");
                },
                backgroundColor: EpicHireTheme.of(context).background,
                borderColor: EpicHireTheme.of(
                  context,
                ).gray.withValues(alpha: 1),
                child: Text(
                  "Continue as Guest",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ],

        // child: Text(
        //   "Landing Screen!",
        //   style: Theme.of(
        //     context,
        //   ).textTheme.bodyMedium!.copyWith(color: theme.dirtyWhite),
        // ),
      ),
    );
  }
}
