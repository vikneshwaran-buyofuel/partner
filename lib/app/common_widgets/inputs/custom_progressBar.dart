import 'package:flutter/material.dart';
import 'package:partner/core/constants/app_colors.dart';

class CustomProgressBar extends StatelessWidget {
  final double value; // Current value
  final double maxValue; // Maximum value
  final double height;
  final Color backgroundColor;
  final Color progressColor;
  final Gradient? progressGradient;
  final BorderRadius? borderRadius;

  const CustomProgressBar({
    Key? key,
    required this.value,
    required this.maxValue,
    this.height = 12.0,
    this.backgroundColor = const Color(0xFFE0E0E0), // Light gray for unfilled area
    this.progressColor = const Color(0xFFf59e0b),
    this.progressGradient,
    this.borderRadius,
  })  : assert(maxValue > 0, 'maxValue must be greater than 0'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final clampedProgress = (value / maxValue).clamp(0.0, 1.0);
    final radius = borderRadius ?? BorderRadius.circular(height / 2);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: radius,
      ),
      child: Stack(
        children: [
          // Progress fill
          ClipRRect(
            borderRadius: radius,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: clampedProgress,
                child: Container(
                  color: progressGradient == null ? progressColor : null,
                  decoration: progressGradient != null
                      ? BoxDecoration(gradient: progressGradient)
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}