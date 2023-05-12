import 'package:flutter/material.dart';
import 'package:summarize_app/views/pages/onboarding/otp_view.dart';

class AppOTPDialog {
  static launchOTPActivity(String verificationId, String phoneNumber,
          BuildContext context, String username) =>
      showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              child: OTPView(
                phoneNumber: phoneNumber,
                username: username,
              ),
            ),
          );
        },
      );
}
