import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pill_cart/utils/theme.dart';

/// Displays a custom snackbar with the given parameters.
///
/// This function uses the GetX package to show a snackbar with a custom design.
/// It allows for customization of the title, message, type, duration, color, and dismissibility.
///
/// @param title The title of the snackbar.
/// @param message The message to display in the snackbar.
/// @param type The type of the snackbar, which determines its color.
/// @param duration The duration for which the snackbar should be displayed.
/// @param color The background color of the snackbar.
/// @param isDismissible Whether the snackbar can be dismissed by the user.
customSnackbar(title, message, type, duration, color, {isDismissible = true}) {
  Get.snackbar(
    // Empty title and message placeholders
    '',
    '',

    titleText: Text(
      title,
      style: customLightTheme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
    ),
    messageText: Text(
      message,
      style: customLightTheme.textTheme.labelMedium,
    ),
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    isDismissible: isDismissible,
    animationDuration: const Duration(milliseconds: 200),
    overlayBlur: 1,
    duration: const Duration(milliseconds: 2000),
    snackStyle: SnackStyle.FLOATING,
    barBlur: 6,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: type == "error" ? Colors.red[400]?.withOpacity(0.7) : color,
    colorText: Colors.black,
  );
}
