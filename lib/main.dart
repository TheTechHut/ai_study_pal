import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/firebase_options.dart';
import 'package:summarize_app/view_model/firebase/firebase_auth.dart';
import 'package:summarize_app/view_model/network_provider/summary_provider.dart';
import 'package:summarize_app/view_model/pdf_handler/pdf_provider.dart';
import 'package:summarize_app/views/onboarding/screen_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        ChangeNotifierProvider.value(
          value: FirebaseAuthProvider.initialize(),
        ),
      ],
      child: MaterialApp(
        home: const ScreenController(),
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
