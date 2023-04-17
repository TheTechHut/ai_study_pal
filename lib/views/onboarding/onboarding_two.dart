import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/const/app_constant_imports.dart';
import 'package:summarize_app/services/toast_service.dart';
import 'package:summarize_app/view_model/firebase/firebase_auth.dart';
import 'package:summarize_app/views/core/homepage.dart';
import 'package:summarize_app/views/splash/splash.dart';
import 'package:url_launcher/url_launcher.dart';

class OnBoarding2 extends StatefulWidget {
  final String username;
  const OnBoarding2({super.key, required this.username});

  @override
  State<OnBoarding2> createState() => _OnBoardingState2();
}

class _OnBoardingState2 extends State<OnBoarding2> {
  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumber = TextEditingController();
    TextEditingController userName =
        TextEditingController(text: widget.username);
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDimension.big),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacing.largeHeight(),
                Container(
                  padding: const EdgeInsets.all(AppDimension.medium),
                  margin: const EdgeInsets.all(AppDimension.big),
                  child: Image.asset(
                    AppAssets.appLogo2,
                    fit: BoxFit.cover,
                  ),
                ),
                const Spacing.bigHeight(),

                // It runs the validator of each text field in the child
                //For it to work you must return error states after strings that the validator will use
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: phoneNumber,
                        keyboardType: TextInputType.phone,
                        hintText: 'Enter Phone Number',
                        labelText: 'Phone Number',
                        validator: (phone) {
                          final regex = RegExp(r'^0[0-9]*$');
                          final nonNullNumber = phone ?? "";
                          if (nonNullNumber.isEmpty) {
                            return "Phone number is required";
                          }
                          if (!regex.hasMatch(nonNullNumber)) {
                            return "Please enter a valid phone number";
                          }
                          if (nonNullNumber.length != 10) {
                            return "Phone number must have 10 digits";
                          }
                          return null;
                        },
                      ),
                      const Spacing.bigHeight(),
                      Consumer<FirebaseAuthProvider>(
                        builder: (context, phoneAuthProvider, child) {
                          return AppElevatedButton(
                            onPressed: () async {
                              log(formKey.currentState!.validate().toString());
                              if (formKey.currentState!.validate()) {
                                if (phoneNumber.text.isNotEmpty &&
                                    userName.text.isNotEmpty) {
                                  await phoneAuthProvider.createUser(
                                    phoneNumber: phoneNumber.text
                                        .replaceFirst('0', '+254')
                                        .trim(),
                                    context: context,
                                    username: userName.text,
                                  );
                                }
                                if (phoneAuthProvider.isloading) {
                                  if (context.mounted) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => const Splash(),
                                      ),
                                    );
                                  }
                                }
                                if (phoneAuthProvider.errorMessage.isNotEmpty) {
                                  showToast(
                                    "Oops Something went wrong",
                                    color: AppColor.kGrayErrorColor,
                                  );
                                  showErrorDialog(
                                      phoneAuthProvider.errorMessage);
                                }

                                if (phoneAuthProvider.errorMessage.isEmpty) {
                                  showToast("Success",
                                      color: AppColor.kSecondaryColor);
                                  if (context.mounted) return;
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(
                                        userName: phoneAuthProvider.username,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            label: "Submit",
                            borderColor: AppColor.kPrimaryColor,
                            isLoading: false,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showErrorDialog(String errorMessage) => showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    await _launchURLApp(errorMessage);
                  },
                  child: const Text("Report Error"),
                ),
              ));
        },
      );
  _launchURLApp(String errormessage) async {
    var contact = "+254115017058";
    var androidUrl =
        "whatsapp://send?phone=$contact&text=Help I'm Using The StudyPalApp And I'm Getting The Following Error Message $errormessage";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      showToast("error");
    }
  }
}
