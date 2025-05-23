import 'package:epic_hire/features/authentication/utils/hive.dart';
import 'package:epic_hire/features/router/controller.dart';
import 'package:epic_hire/theme/themes/dark.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:epic_hire/shared/utils/web/web_utils.dart'
    if (dart.library.io) 'package:epic_hire/shared/utils/web/non_web_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );

  initializePlatform();

  await setupHive();

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarContrastEnforced: false,
      ),
    );

    return MaterialApp.router(
      title: 'EpicHire',
      themeMode: ThemeMode.dark,
      theme: getDarkTheme(context),
      darkTheme: getDarkTheme(context),
      routerConfig: routerController,
    );
  }
}
