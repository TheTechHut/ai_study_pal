import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/const/app_constant_imports.dart';
import 'package:summarize_app/services/toast_service.dart';
import 'package:summarize_app/view_model/firebase/firebase_auth.dart';
import 'package:summarize_app/views/core/homepage.dart';
import 'package:summarize_app/views/splash/splash.dart';
import 'package:url_launcher/url_launcher.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    final phoneAuthProvider = Provider.of<FirebaseAuthProvider>(context);
    TextEditingController phoneNumber = TextEditingController();
    TextEditingController userName = TextEditingController();
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
                // Text(
                //   'Study Pal',
                //   style: AppTextStyle.heading1.copyWith(
                //     color: AppColor.kSecondaryColor,
                //   ),
                // ),
                AppTextField(
                  controller: userName,
                  hintText: 'Enter Username',
                  labelText: 'Username',
                  onSubmitted: (p0) {
                    if (userName.text.isEmpty) {
                      showToast("Username can't be empty");
                    }
                  },
                ),

                const Spacing.bigHeight(),
                AppTextField(
                  controller: phoneNumber,
                  keyboardType: TextInputType.phone,
                  hintText: 'Enter Phone Number',
                  labelText: 'Phone Number',
                  onSubmitted: (p0) {
                    final regex = RegExp(r'^0[0-9]*$');
                    if (phoneNumber.text.isEmpty) {
                      showToast("Phone number is required");
                    } else if ((!regex.hasMatch(phoneNumber.text)) &&
                        phoneNumber.text.length != 10) {
                      showToast("Please enter a valid phone number");
                    }
                  },
                ),
                const Spacing.bigHeight(),
                AppElevatedButton(
                  onPressed: () async {
                    // SharedPreferences prefs =
                    //     await SharedPreferences.getInstance();

                    // prefs.setString("inputusername", userName.text);
                    // prefs.setString("inputphone", phoneNumber.text);

                    if (phoneNumber.text.isEmpty ||
                        phoneNumber.text.length < 10) {
                      showToast("Please Enter a phone number");
                    } else if (phoneNumber.text.isNotEmpty &&
                        userName.text.isNotEmpty) {
                      await phoneAuthProvider.createUser(
                        phoneNumber:
                            phoneNumber.text.replaceFirst('0', '+254').trim(),
                        context: context,
                        username: userName.text,
                      );
                    } else if (phoneAuthProvider.errorMessage.isNotEmpty) {
                      showToast("Oops Something went wrong");
                      showErrorDialog(phoneAuthProvider.errorMessage);
                    } else {
                      showToast("Success");
                      if (context.mounted) return;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            userName: phoneAuthProvider.username,
                          ),
                        ),
                      );
                    }
                    if (phoneAuthProvider.isloading) {
                      if (context.mounted) return;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Splash(),
                        ),
                      );
                    }
                  },
                  label: "Submit",
                  borderColor: AppColor.kPrimaryColor,
                  isLoading: phoneAuthProvider.isloading,
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
