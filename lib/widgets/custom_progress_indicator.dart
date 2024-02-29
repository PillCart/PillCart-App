import 'package:flutter/material.dart';
import 'package:pill_cart/helper/constant.dart';

/// A custom circular progress indicator with a customizable stroke width,
/// stroke cap, background color, and progress color.
class CustomLinearProgressIndicator extends StatelessWidget {
  const CustomLinearProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: kBrand300,
      borderRadius: BorderRadius.circular(16),
      minHeight: 6,
      color: kBrand500,
    );
  }
}

/// A custom linear progress indicator with a customizable background color,
/// border radius, minimum height, and progress color.
class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      strokeCap: StrokeCap.round,
      strokeWidth: 6,
      backgroundColor: kBrand300,
      color: kBrand500,
    );
  }
}
