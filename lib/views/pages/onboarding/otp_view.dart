import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/shared/app_constant_imports.dart';
import 'package:summarize_app/services/toast/toast_service.dart';
import 'package:summarize_app/shared/functions/app_error_dialog.dart';
import 'package:summarize_app/view_model/firebase/firebase_auth.dart';
import 'package:summarize_app/views/pages/home/homepage.dart';

class OTPView extends StatelessWidget {
  final String phoneNumber;
  final String username;

  const OTPView({super.key, required this.phoneNumber, required this.username});

  @override
  Widget build(BuildContext context) {
    return OtpScreen(
      phoneNumber: phoneNumber,
      userName: username,
    );
  }
}

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String userName;
  const OtpScreen(
      {super.key, required this.phoneNumber, required this.userName});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int _counter = 20;
  late Timer _timer;
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  final bool _isloading = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(
          () {
            if (_counter > 0) {
              _counter--;
            } else {
              _timer.cancel();
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otpProvider = Provider.of<FirebaseAuthProvider>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Verify your phone number below",
            style: AppTextStyle.boldHeading2,
          ),
          const Spacing.meduimHeight(),
          Text(
            'Enter OTP sent to ${otpProvider.phoneNumber}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacing.height(20),
          PinCodeTextField(
            controller: _codeController,
            focusNode: _otpFocusNode,
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
            ),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            onChanged: (value) {
              // Handle OTP changes
            },
            onCompleted: (value) async {
              // Handle completed OTP input
              //await otpProvider.signInWithPhoneNumber(value);
            },
            appContext: context,
          ),
          const Spacing.height(20),
          Text(
            '$_counter seconds left',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const Spacing.height(20),
          ElevatedButton(
            onPressed: _isloading
                ? null
                : () async {
                    await otpProvider
                        .signInWithPhoneNumber(_codeController.text)
                        .whenComplete(
                      () {
                        if (otpProvider.errorMessage.isEmpty) {
                          showToast("Success");
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(userName: widget.userName),
                            ),
                          );
                        } else {
                          showToast(
                            "Oops something went wrong. You can report the error or try again",
                          );
                          AppErrorDialog.showErrorDialog(
                            otpProvider.errorMessage,
                            context,
                          );
                        }
                      },
                    );
                  },
            child: _isloading
                ? const CircularProgressIndicator()
                : const Text('Verify OTP'),
          ),
          const Spacing.smallHeight(),
          TextButton(
            onPressed: () async {
              await otpProvider.resendVerificationCode();
              if (otpProvider.errorMessage.isNotEmpty) {
                showToast("Please try again");
                log(otpProvider.errorMessage);
              } else {
                showToast("Success");
              }
            },
            child: Text(
              "Resend Verification code",
              style: AppTextStyle.body6.copyWith(
                color: AppColor.kSecondaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
      ),
    );
  }
}
