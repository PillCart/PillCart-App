/// A custom outline button widget for the PillCart application.
/// This widget is a stateless widget that creates a button with a customizable
/// text, color, and onPressed callback. It uses the ElevatedButton widget from Flutter
/// with a custom style to achieve the desired appearance.
import 'package:flutter/material.dart';
import 'package:pill_cart/utils/theme.dart';

class COutlineButton extends StatelessWidget {
  /// The text displayed on the button.
  final String buttonText;

  /// The color of the button's outline and text.
  final Color color;

  /// The callback function that is called when the button is pressed.
  final VoidCallback onPressed;

  /// Creates a new instance of the COutlineButton widget.
  ///
  /// Requires the [buttonText], [onPressed], and [color] parameters to be provided.
  const COutlineButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46, // Sets the height of the button.
      child: ElevatedButton(
        onPressed: onPressed, // The callback function to be called when the button is pressed.
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 0), // Sets the minimum size of the button.
          backgroundColor: Colors.white, // Sets the background color of the button.
          foregroundColor: color, // Sets the color of the button's text.
          animationDuration: const Duration(milliseconds: 300), // Sets the duration of the button's animation.
          elevation: 6, // Sets the elevation of the button.
          side: BorderSide(
            width: 2, // Sets the width of the button's outline.
            color: color, // Sets the color of the button's outline.
          ),
          shadowColor: Colors.black26, // Sets the color of the button's shadow.
          textStyle: customLightTheme.textTheme.labelLarge?.copyWith(fontSize: 20), // Sets the text style of the button's text.
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Sets the shape of the button with a rounded rectangle border.
        ),
        child: Text(
          buttonText, // The text displayed on the button.
        ),
      ),
    );
  }
}
