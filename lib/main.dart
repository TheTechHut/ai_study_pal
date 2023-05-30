import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/firebase_options.dart';
import 'package:summarize_app/services/analytics/analytics_service.dart';
import 'package:summarize_app/view_model/firebase/firebase_auth.dart';
import 'package:summarize_app/view_model/network_provider/questions_provider.dart';
import 'package:summarize_app/view_model/network_provider/summary_provider.dart';
import 'package:summarize_app/view_model/pdf_handler/pdf_provider.dart';
import 'package:summarize_app/views/pages/onboarding/screen_controller.dart';

import 'views/providers/mainpage/mainpage_provider.dart';

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
        ChangeNotifierProvider(create: (_) => MainPageProvider()),
        // ChangeNotifierProvider.value(
        //   value: FirebaseAuthProvider.initialize(),
        // ),
      ],
      child: MaterialApp(
        home: const ScreenController(),
        navigatorObservers: [AnalyticsService.getObserver()],
        theme: ThemeData(
          primarySwatch: const MaterialColor(0XFF093E76, {
            50: Colors.blueAccent,
            100: Colors.black,
            200: Colors.black,
            300: Colors.black,
            400: Colors.black,
            500: Colors.black,
            600: Colors.white,
            700: Colors.black,
            800: Colors.black,
            900: Colors.black,
          }),
        ),
      ),
    ),
  );
}
