import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:faseeh_kids/firebase_options.dart';
import 'package:faseeh_kids/core/theme/app_theme.dart';
import 'package:faseeh_kids/core/router/app_router.dart';
import 'package:faseeh_kids/core/storage/hive_init.dart';
import 'package:faseeh_kids/services/revenue_cat_service.dart';

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

  // ──── Firebase Initialization ────
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ──── RevenueCat Initialization ────
  await RevenueCatService.instance.init();

  // ──── Crashlytics: Catch all Flutter errors ────
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // ──── Crashlytics: Catch async errors outside Flutter framework ────
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Run the app inside a zone to catch any remaining errors
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // ─── Navigation ───
      routerConfig: AppRouter.router,
    );
  }
}
