import 'package:flutter/material.dart';
import 'package:summarize_app/shared/functions/launch_whatsapp.dart';

class AppErrorDialog {
  static showErrorDialog(String errorMessage, BuildContext context) =>
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    LaunchWhatsApp.launchWhatsApp(message: errorMessage);
                  },
                  child: const Text("Report Error"),
                ),
              ));
        },
      );
}
