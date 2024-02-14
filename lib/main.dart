import 'package:ai_study_pal/firebase_options.dart';
import 'package:ai_study_pal/res/components/app_theme.dart';
import 'package:ai_study_pal/services/analytics_service.dart';
import 'package:ai_study_pal/view_model/firebase/firebase_auth.dart';
import 'package:ai_study_pal/view_model/network_provider/questions_provider.dart';
import 'package:ai_study_pal/view_model/network_provider/summary_provider.dart';
import 'package:ai_study_pal/view_model/pdf_handler/pdf_provider.dart';
import 'package:ai_study_pal/views/onboarding/screen_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PdfProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SummaryProvider(),
        ),
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (_) => QuestionsProvider()),
        // ChangeNotifierProvider.value(
        //   value: FirebaseAuthProvider.initialize(),
        // ),
      ],
      child: MaterialApp(
        home: const ScreenController(),
        navigatorObservers: [AnalyticsService.getObserver()],
        darkTheme: themeDark,
        theme: themeLight,
        themeMode: ThemeMode.system,
      ),
    ),
  );
}
