import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:summarize_app/shared/styles/app_colors.dart';

class AppTextStyle {
  AppTextStyle._();
  static TextStyle heading1 = GoogleFonts.dmSans(
    fontSize: 48,
    fontWeight: FontWeight.bold,
  );
  static TextStyle heading2 = GoogleFonts.dmSans(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  static TextStyle boldHeading2 = GoogleFonts.dmSans(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
  static TextStyle whiteBoldHeading2 = GoogleFonts.dmSans(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColor.kGrayNeutralColor.shade100);
  static TextStyle heading3 = GoogleFonts.dmSans(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static TextStyle heading4 = GoogleFonts.dmSans(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static TextStyle boldHeading4 = GoogleFonts.dmSans(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: const Color(0xFF000000));
  static TextStyle heading5 = GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle heading6 = GoogleFonts.dmSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle body1 = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static TextStyle body2 = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  static TextStyle body3 = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static TextStyle body4 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle bodyBold4 = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle whiteBody4 = GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColor.kGrayNeutralColor.shade100);
  static TextStyle boldBody5 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static TextStyle whiteBody5 = GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.kGrayNeutralColor.shade100);
  static TextStyle body5 = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle body6 = GoogleFonts.inter(
    color: const Color(0xff000000),
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static TextStyle boldBody6 = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
  static TextStyle errorText = GoogleFonts.inter(
    fontSize: 20,
    color: AppColor.kGrayErrorColor.shade800,
    fontWeight: FontWeight.w400,
  );
  static TextStyle summaryText = GoogleFonts.inter(
    fontSize: 12,
    color: AppColor.kSecondaryColor.shade800,
    fontWeight: FontWeight.w500,
  );
}
