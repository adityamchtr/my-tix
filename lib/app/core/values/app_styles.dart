import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:blitix/app/core/values/app_colors.dart';
import 'package:blitix/app/core/values/app_values.dart';
import 'package:pinput/pinput.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Font Size Default
/// displayLarge 112.0
/// displayMedium 56.0
/// displaySmall 45.0
/// headlineLarge 40.0
/// headlineMedium 34.0
/// headlineSmall 24.0
/// titleLarge 20.0
/// titleMedium 16.0
/// titleSmall 14.0
/// bodyLarge 14.0
/// bodyMedium 14.0
/// bodySmall 12.0
/// labelLarge 14.0
/// labelMedium 12.0
/// labelSmall 10.0
//const TextTheme textTheme = TextTheme();

SystemUiOverlayStyle systemUiOverlayStyle(ThemeData theme, {bool isBackground = false}) {
  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: isBackground ? theme.colorScheme.background : theme.scaffoldBackgroundColor,
  );
}

PinTheme pinTheme(ThemeData theme) {
  return PinTheme(
    width: 55.0,
    height: 55.0,
    margin: const EdgeInsets.symmetric(
      horizontal: AppValues.halfPadding
    ),
    textStyle: const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(AppValues.smallRadius),
      border: Border.all(color: theme.dividerColor),
    ),
  );
}

ShimmerEffect shimmerEffect() {
  return const ShimmerEffect(
    duration: Duration(milliseconds: 1000)
  );
}

showSnackBar({required String title, required String message, bool isSuccess = true}) {
  return Get.snackbar(title, message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: const Color(0xFF242C32),
    colorText: Colors.white,
    duration: const Duration(seconds: 2),
    icon: Container(
      padding: const EdgeInsets.all(AppValues.buttonVerticalPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppValues.extraLargeRadius),
        boxShadow: [
          BoxShadow(
            color: (isSuccess ? AppColors.colorGreen : AppColors.colorRed).withOpacity(0.2),
            spreadRadius: 20.0,
            blurRadius: 40.0,
          ),
        ]
      ),
      child: Icon(Icons.check_circle_rounded,
        color: isSuccess ? AppColors.colorGreen : AppColors.colorRed,
      ),
    ),
    margin: const EdgeInsets.only(
      left: AppValues.padding,
      right: AppValues.padding,
      bottom: AppValues.padding + kBottomNavigationBarHeight
    )
  );
}