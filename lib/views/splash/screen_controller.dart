import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/view_model/firebase/firebase_auth.dart';
import 'package:summarize_app/views/core/homepage.dart';
import 'package:summarize_app/views/onboarding/onboarding.dart';
import 'package:summarize_app/views/splash/splash.dart';

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<FirebaseAuthProvider>(context);
    if (auth.status == Status.Uninitialized) {
      return const Splash();
    } else if (auth.status == Status.Unauthenticated) {
      return const OnBoarding();
    } else {
      return HomePage(userName: auth.username);
    }
  }
}
