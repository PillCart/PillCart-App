// ignore_for_file: must_be_immutable

/// A custom primary button widget for the PillCart application.
/// This widget is a stateless widget that creates a button with a customizable
/// text, color, and onPressed callback. It uses the ElevatedButton widget from Flutter
/// with a custom style to achieve the desired appearance.
import 'package:flutter/material.dart';
import 'package:pill_cart/utils/theme.dart';

class CPrimaryButton extends StatelessWidget {
  /// The widget that displays the button's text.
  final Widget buttonText;

  /// The color of the button.
  final Color color;

  /// The callback function that is called when the button is pressed.
  final VoidCallback onPressed;

  /// Determines whether the button is enabled or disabled.
  final bool? isEnabled;

  /// Creates a new instance of the CPrimaryButton widget.
  ///
  /// Requires the [buttonText], [onPressed], and [color] parameters to be provided.
  /// Optionally, the [isEnabled] parameter can be provided to set the button's enabled state.
  const CPrimaryButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.color,
    this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46, // Sets the height of the button.
      child: ElevatedButton(
        onPressed: isEnabled! ? onPressed : null, // Determines if the button is enabled or disabled.
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 0), // Sets the minimum size of the button.
          backgroundColor: color, // Sets the background color of the button.
          foregroundColor: Colors.white, // Sets the color of the button's text.
          elevation: 6, // Sets the elevation of the button.
          shadowColor: Colors.black26, // Sets the color of the button's shadow.
          textStyle: customLightTheme.textTheme.labelLarge?.copyWith(fontSize: 20), // Sets the text style of the button's text.
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Sets the shape of the button with a rounded rectangle border.
        ),
        child: buttonText, // The widget that displays the button's text.
      ),
    );
  }
}
