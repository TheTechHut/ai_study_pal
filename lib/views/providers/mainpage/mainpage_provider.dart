import 'package:flutter/material.dart';
import 'package:summarize_app/view_model/firebase/firebase_auth.dart';
import 'package:summarize_app/views/pages/home/homepage.dart';
import 'package:summarize_app/views/pages/settings/settings_page.dart';
import 'package:summarize_app/views/pages/upload/upload_page.dart';

class MainPageProvider extends FirebaseAuthProvider implements ChangeNotifier {
  FirebaseAuthProvider auth = FirebaseAuthProvider();
  List<Widget> pageViews = [
    const HomePage(),
    const UploadPage(),
    const SettingsPage(),
  ];
}
