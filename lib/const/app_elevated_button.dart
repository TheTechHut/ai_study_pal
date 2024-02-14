import 'package:flutter/material.dart';
import 'package:ai_study_pal/const/app_constant_imports.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;
  final Color? textColor;
  final Color? buttonColor;
  final Color borderColor;
  const AppElevatedButton(
      {Key? key,
      this.onPressed,
      required this.label,
      required this.isLoading,
      this.buttonColor,
      required this.borderColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        side: MaterialStateProperty.all(
          BorderSide(color: borderColor),
        ),
        foregroundColor: MaterialStateProperty.all(AppColor.kGrayNeutralColor),
        overlayColor:
            MaterialStateProperty.all(AppColor.kSecondaryColor.shade100),
        fixedSize: MaterialStateProperty.all(
          const Size(375, 48),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimension.small * 1.5,
            ),
          ),
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              label,
              style: AppTextStyle.body4.copyWith(color: textColor),
            ),
    );
  }
}
