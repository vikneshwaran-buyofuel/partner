import 'package:flutter/material.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';
import 'package:partner/core/constants/enum.dart';

class CustomBadge extends StatelessWidget {
  final String badge;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  const CustomBadge({
    Key? key,
    required this.badge,
    this.height = 16,
    this.width,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: CustomText(
        title: badge,
        fitInContainer: true,
        variant: TextVariant.labelSmall,
      ),
    );
  }
}



