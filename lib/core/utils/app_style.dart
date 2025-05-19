import 'package:flutter/material.dart';
import 'app_colors.dart'; // Assuming this file exists with color constants
import 'responsive.dart';
import 'responsive_helper.dart';

class AppStyle {
  // Private constructor to prevent instantiation
  AppStyle._();

  // Typography (Responsive)
  static TextStyle heading1(BuildContext context) => TextStyle(
    fontSize: ResponsiveHelper.getFontSize(context, 28),
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
    fontFamily: 'Roboto', // Adjust based on your font setup
  );

  static TextStyle heading2(BuildContext context) => TextStyle(
    fontSize: ResponsiveHelper.getFontSize(context, 24),
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
    fontFamily: 'Roboto',
  );

  static TextStyle bodyText(BuildContext context) => TextStyle(
    fontSize: ResponsiveHelper.getFontSize(context, 16),
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
    fontFamily: 'Roboto',
  );

  static TextStyle caption(BuildContext context) => TextStyle(
    fontSize: ResponsiveHelper.getFontSize(context, 14),
    fontWeight: FontWeight.normal,
    color: AppColors.greyColor,
    fontFamily: 'Roboto',
  );

  // Padding (Responsive)
  static EdgeInsets defaultPadding(BuildContext context) =>
      ResponsiveHelper.getPadding(context);

  static EdgeInsets smallPadding(BuildContext context) =>
      EdgeInsets.all(Responsive.of(context).fontSize(8));

  static EdgeInsets largePadding(BuildContext context) =>
      EdgeInsets.all(Responsive.of(context).fontSize(24));

  // Border Radius
  static BorderRadius borderRadiusSmall = BorderRadius.circular(8.0);
  static BorderRadius borderRadiusMedium = BorderRadius.circular(12.0);
  static BorderRadius borderRadiusLarge = BorderRadius.circular(16.0);

  // Box Shadow
  static List<BoxShadow> defaultShadow = [
    BoxShadow(
      color: AppColors.greyColor.withOpacity(0.1),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  // Button Styles
  static ButtonStyle primaryButtonStyle(BuildContext context) =>
      ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        textStyle: bodyText(context).copyWith(fontWeight: FontWeight.w600),
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.of(context).fontSize(16),
          vertical: Responsive.of(context).fontSize(12),
        ),
        shape: RoundedRectangleBorder(borderRadius: borderRadiusMedium),
      );

  static ButtonStyle secondaryButtonStyle(BuildContext context) =>
      OutlinedButton.styleFrom(
        foregroundColor: AppColors.secondaryColor,
        side: BorderSide(color: AppColors.secondaryColor),
        textStyle: bodyText(context).copyWith(fontWeight: FontWeight.w600),
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.of(context).fontSize(16),
          vertical: Responsive.of(context).fontSize(12),
        ),
        shape: RoundedRectangleBorder(borderRadius: borderRadiusMedium),
      );

  // Theme Data
  static ThemeData appTheme(BuildContext context) => ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: TextTheme(
      headlineLarge: heading1(context),
      headlineMedium: heading2(context),
      bodyMedium: bodyText(context),
      bodySmall: caption(context),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: primaryButtonStyle(context),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: secondaryButtonStyle(context),
    ),
    fontFamily: 'Roboto', // Adjust based on your font setup
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      background: AppColors.backgroundColor,
    ),
  );
}
