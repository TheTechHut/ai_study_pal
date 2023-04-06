import 'package:flutter/material.dart';
import 'package:summarize_app/const/app_constant_imports.dart';

class Spacing extends StatelessWidget {
  final double height;
  final double width;

  const Spacing.height(this.height, {super.key}) : width = AppDimension.zero;

  const Spacing.tinyHeight({
    this.width = AppDimension.zero,
    super.key,
  }) : height = AppDimension.tiny;

  const Spacing.smallHeight({
    this.width = AppDimension.zero,
    super.key,
  }) : height = AppDimension.small;

  const Spacing.meduimHeight({
    this.width = AppDimension.zero,
    super.key,
  }) : height = AppDimension.medium;

  const Spacing.bigHeight({
    this.width = AppDimension.zero,
    super.key,
  }) : height = AppDimension.big;

  const Spacing.largeHeight({
    this.width = AppDimension.zero,
    super.key,
  }) : height = AppDimension.large;

  const Spacing.width(this.width, {super.key}) : height = AppDimension.zero;

  const Spacing.tinyWidth({
    this.height = AppDimension.zero,
    super.key,
  }) : width = AppDimension.tiny;

  const Spacing.smallWidth({
    this.height = AppDimension.zero,
    super.key,
  }) : width = AppDimension.small;

  const Spacing.meduimWidth({
    this.height = AppDimension.zero,
    super.key,
  }) : width = AppDimension.medium;

  const Spacing.bigWidth({
    this.height = AppDimension.zero,
    super.key,
  }) : width = AppDimension.big;

  const Spacing.largeWidth({
    this.height = AppDimension.zero,
    super.key,
  }) : width = AppDimension.large;

  const Spacing.empty({super.key})
      : height = AppDimension.zero,
        width = AppDimension.zero;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
