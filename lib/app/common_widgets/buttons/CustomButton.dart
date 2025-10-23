import 'package:flutter/material.dart';
import 'package:partner/core/constants/enum.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final double? height;
  final double? width;
  final bool fullWidth;
  final bool isLoading;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.height,
    this.width,
    this.fullWidth = false,
    this.isLoading = false,
    this.leadingIcon,
    this.trailingIcon,
    this.padding,
    this.borderRadius,
  });

  // Height mapping
  double get _defaultHeight {
    switch (size) {
      case ButtonSize.xsmall:
        return 27.0;
      case ButtonSize.small:
        return 31.0;
      case ButtonSize.medium:
        return 46.0;
      case ButtonSize.large:
        return 46.0; // keep same as medium unless overridden
    }
  }

  // Width mapping
  double? get _defaultWidth {
    if (fullWidth) return double.infinity;

    switch (size) {
      case ButtonSize.xsmall:
        return width ?? 136.0; // dynamic if provided
      case ButtonSize.small:
        return width ?? 162.5;
      case ButtonSize.medium:
        return width ?? 178.5;
      case ButtonSize.large:
        return width ?? 361.0;
    }
  }

  // Font size mapping
  double get _fontSize {
    switch (size) {
      case ButtonSize.xsmall:
        return 12.0;
      case ButtonSize.small:
        return 13.0;
      case ButtonSize.medium:
        return 15.0;
      case ButtonSize.large:
        return 16.0;
    }
  }

  // Default padding
  EdgeInsetsGeometry get _defaultPadding {
    switch (size) {
      case ButtonSize.xsmall:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 4);
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    }
  }

  // Background color
  Color _getBackgroundColor(BuildContext context) {
    final theme = Theme.of(context);
    if (onPressed == null) return Colors.grey.shade300;

    switch (variant) {
      case ButtonVariant.primary:
        return theme.primaryColor;
      case ButtonVariant.secondary:
        return Colors.grey.shade200;
      case ButtonVariant.outline:
      case ButtonVariant.ghost:
        return Colors.transparent;
      case ButtonVariant.destructive:
        return Colors.red;
    }
  }

  // Text color
  Color _getTextColor(BuildContext context) {
    if (onPressed == null) return Colors.grey.shade600;

    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.destructive:
        return Colors.white;
      case ButtonVariant.secondary:
        return Colors.black87;
      case ButtonVariant.outline:
      case ButtonVariant.ghost:
        return Theme.of(context).primaryColor;
    }
  }

  // Border for outline variant
  BorderSide? _getBorderSide(BuildContext context) {
    if (variant == ButtonVariant.outline) {
      return BorderSide(
        color: onPressed == null
            ? Colors.grey.shade300
            : Theme.of(context).primaryColor,
        width: 1.5,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final buttonWidth = fullWidth ? double.infinity : width ?? _defaultWidth;
    final buttonHeight = height ?? _defaultHeight;
    final buttonPadding = padding ?? _defaultPadding;
    final buttonBorderRadius = borderRadius ?? BorderRadius.circular(8.0);

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getBackgroundColor(context),
          foregroundColor: _getTextColor(context),
          padding: buttonPadding,
          elevation: variant == ButtonVariant.primary && onPressed != null
              ? 2
              : 0,
          shadowColor: variant == ButtonVariant.primary
              ? Colors.black26
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: buttonBorderRadius,
            side: _getBorderSide(context) ?? BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getTextColor(context),
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leadingIcon != null) ...[
                    leadingIcon!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: _fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (trailingIcon != null) ...[
                    const SizedBox(width: 8),
                    trailingIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
