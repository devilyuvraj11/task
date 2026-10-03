import 'package:flutter/material.dart';

class Responsive {
  static const double designWidth = 375.0;
  static double width(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }
  static double height(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double scale(BuildContext context, double value) {
    final screenWidth = width(context);
    return value * (screenWidth / designWidth);
  }
  static double clamp(
      BuildContext context,
      double value, {double min = 0, double max = double.infinity,}) {
    final scaled = scale(context, value);

    return scaled.clamp(min, max).toDouble();
  }

  static double horizontalPadding(BuildContext context) {
    return clamp(context, 20, min: 16, max: 24,);
  }

  static double cardRadius(BuildContext context) {
    return clamp(context, 20, min: 16, max: 22,);
  }
}