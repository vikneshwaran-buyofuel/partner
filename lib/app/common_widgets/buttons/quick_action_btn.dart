import 'package:flutter/material.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';

class QuickActionButton extends StatefulWidget {
  final IconData icon;
  final String? label;
  final VoidCallback onTap;
  final Color primaryColor;
  final double height;
  final double width;
  final double borderRadius;

  const QuickActionButton({
    Key? key,
    required this.icon,
     this.label,
    required this.onTap,
    this.primaryColor = const Color(0xFF4CAF50),
    this.height = 120,
    this.width = 120,
    this.borderRadius = 0,
  }) : super(key: key);

  @override
  State<QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<QuickActionButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.05),
          child: InkWell(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            onTap: widget.onTap,
            child: Container(
              width: widget.width,
              height: widget.height,
              padding: const EdgeInsets.all(16),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Icon(widget.icon, color: widget.primaryColor),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
       if (widget.label != null) CustomText(title: widget.label!),
      ],
    );
  }
}
