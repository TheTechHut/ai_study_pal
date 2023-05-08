import 'package:flutter/material.dart';
import 'package:summarize_app/shared/app_constant_imports.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  const AppTextField(
      {Key? key,
      this.controller,
      this.focusNode,
      this.textInputAction,
      this.onSubmitted,
      this.validator,
      this.prefixIcon,
      this.suffixIcon,
      required this.hintText,
      required this.labelText,
      this.obscureText = false,
      this.keyboardType,
      AutovalidateMode? autoValidateMode,
      String? errorText,
      int? maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimension.small),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   labelText,
          //   style: AppTextStyle.body5
          //       .copyWith(color: AppColor.kGrayscaleColor.shade400),
          //   textAlign: TextAlign.left,
          // ),
          const Spacing.smallHeight(),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onFieldSubmitted: onSubmitted,
            focusNode: focusNode,
            textInputAction: textInputAction,
            validator: validator,
            decoration: InputDecoration(
              labelText: labelText,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimension.small),
                borderSide:
                    BorderSide(color: AppColor.kGrayscaleColor.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    BorderSide(color: AppColor.kGrayscaleColor.shade100),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:
                    BorderSide(color: AppColor.kGrayscaleColor.shade100),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                    color: AppColor.kGrayErrorColor.shade500,
                    width: AppDimension.tiny * 0.5),
              ),
              hintStyle: AppTextStyle.body5,
              contentPadding: const EdgeInsets.only(
                  top: 24,
                  bottom: 16,
                  right: AppDimension.big,
                  left: AppDimension.big),
              fillColor: AppColor.kGrayNeutralColor.shade100,
              filled: true,
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 64,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
