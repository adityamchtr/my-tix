import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:match/app/core/values/app_values.dart';
import 'package:pinput/pinput.dart';

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
