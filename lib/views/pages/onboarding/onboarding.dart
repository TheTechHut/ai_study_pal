import 'dart:io';
import 'package:flutter/material.dart';
import 'package:summarize_app/shared/app_constant_imports.dart';
import 'package:summarize_app/services/toast/toast_service.dart';
import 'package:summarize_app/views/pages/onboarding/onboarding_two.dart';
import 'package:url_launcher/url_launcher.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userName = TextEditingController();
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
                Form(
                  key: formKey,
                  child: AppTextField(
                    controller: userName,
                    hintText: 'Enter Username',
                    labelText: 'Username',
                    validator: (username) {
                      if (userName.text.isEmpty) {
                        return "username cant be empty";
                      }
                      if (userName.text.length < 3) {
                        return "Username is too short";
                      }
                      return null;
                    },
                  ),
                ),
                const Spacing.bigHeight(),
                AppElevatedButton(
                  onPressed: () {
                    // Add a click count error that tells a user to enter the phone number without country code
                    //Add a country code feature
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              OnBoarding2(username: userName.text),
                        ),
                      );
                      showToast("Success!", color: AppColor.kSecondaryColor);
                    }
                  },
                  label: "Next",
                  borderColor: AppColor.kPrimaryColor,
                  isLoading: false,
                )
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
