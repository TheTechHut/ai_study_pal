import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarize_app/const/app_constant_imports.dart';
import 'package:summarize_app/services/toast_service.dart';
import 'package:summarize_app/view_model/firebase/firebase_auth.dart';
import 'package:summarize_app/views/onboarding/onboarding.dart';

class UserHeader extends StatelessWidget {
  final String message;
  const UserHeader({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimension.medium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Text(
              message,
              style: AppTextStyle.heading2,
              overflow: TextOverflow.clip,
            ),
          ),
          Consumer<FirebaseAuthProvider>(
            builder: (context, authState, child) {
              return InkWell(
                onTap: () {
                  signOutDialog(
                      context: context,
                      onPressed: () async {
                        await authState.signOut();
                        if (context.mounted) {
                          Center(
                            child: showToast(
                              "COME BACK SOON!",
                              color: AppColor.kSecondaryColor,
                              fromBottom: false,
                              fontSize: 24,
                              shortToast: false,
                            ),
                          );
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const OnBoarding(),
                            ),
                          );
                        }
                      });
                },
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: AppColor.kSecondaryColor,
                  child: Text(
                    authState.username.substring(0, 2),
                    style: AppTextStyle.heading3,
                  ),
                  //child: Image.asset(''),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  signOutDialog(
          {required BuildContext context, required VoidCallback onPressed}) =>
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.height * 0.4,
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppElevatedButton(
                      label: "Sign Out",
                      isLoading: false,
                      borderColor: Colors.transparent,
                      buttonColor: AppColor.kGrayErrorColor,
                      onPressed: onPressed,
                    ),
                    const Spacing.meduimHeight(),
                    AppElevatedButton(
                      label: "Cancel",
                      isLoading: false,
                      borderColor: Colors.transparent,
                      buttonColor: AppColor.kSecondaryColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          });
}
