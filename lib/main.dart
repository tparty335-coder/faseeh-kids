import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faseeh_kids/core/theme/app_theme.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/core/storage/hive_init.dart';

/// فصيح الصغار — Faseeh Kids
/// Arabic Language Learning App for Children (3-10 years)
void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait for children's app
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize Hive local database
  await HiveInit.init();

  // TODO: Initialize Firebase (Phase 10)
  // await Firebase.initializeApp();

  // Run the app wrapped in ProviderScope for Riverpod
  runApp(
    const ProviderScope(
      child: FaseehKidsApp(),
    ),
  );
}

/// Root Application Widget
class FaseehKidsApp extends StatelessWidget {
  const FaseehKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // ─── App Identity ───
      title: 'فصيح الصغار',
      debugShowCheckedModeBanner: false,

      // ─── Theme (Day Mode default, Night Mode via settings) ───
      theme: AppTheme.dayTheme,
      darkTheme: AppTheme.nightTheme,
      themeMode: ThemeMode.light, // Will be dynamic via Riverpod in later phase

      // ─── RTL Support ───
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'), // Arabic
      ],

      // ─── Navigation ───
      routerConfig: AppRouter.router,
    );
  }
}
