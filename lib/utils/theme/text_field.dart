import 'package:flutter/material.dart';
import 'package:service/constant/custom_size.dart';
import 'app_colors.dart';

class CustomTextFormFieldTheme {
  CustomTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppColors.darkGrey,
    suffixIconColor: AppColors.darkGrey,
    labelStyle: const TextStyle().copyWith(
        fontSize: CustomSize.fontSizeSm,
        color: AppColors.textPrimary,
        fontFamily: 'Urbanist'),
    hintStyle: const TextStyle().copyWith(
        fontSize: CustomSize.fontSizeSm,
        color: AppColors.textSecondary,
        fontFamily: 'Urbanist'),
    errorStyle: const TextStyle()
        .copyWith(fontStyle: FontStyle.normal, fontFamily: 'Urbanist'),
    floatingLabelStyle: const TextStyle()
        .copyWith(color: AppColors.textSecondary, fontFamily: 'Urbanist'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSize.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppColors.borderPrimary),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSize.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppColors.borderPrimary),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSize.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppColors.borderSecondary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSize.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: AppColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSize.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: AppColors.error),
    ),
  );
}
