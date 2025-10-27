import 'package:flutter/material.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';
import 'package:partner/core/constants/app_colors.dart';
import 'package:partner/core/constants/enum.dart';
import 'package:partner/core/theme/app_theme.dart';
import 'package:partner/core/utils/app_utils.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final Color? fillcolor;
  final ButtonSize? size;
  final double? height;
  final double? width;
  final bool isLoading;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final EdgeInsetsGeometry? padding;
  final bool? isDisabled;
  final BorderRadius? borderRadius;
  final bool? isSelected;
  final TextVariant fontVarient;

  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.fillcolor,
    this.size,
    this.height,
    this.width,
    this.isLoading = false,
    this.isDisabled = false,
    this.isSelected = true,
    this.leadingIcon,
    this.trailingIcon,
    this.padding,
    this.borderRadius,
    this.fontVarient = TextVariant.labelMedium,
  });

  // Height mapping - only used when size is provided
  double _getHeightForSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.xsmall:
        return 27.0;
      case ButtonSize.small:
        return 31.0;
      case ButtonSize.medium:
        return 46.0;
      case ButtonSize.large:
        return 46.0;
    }
  }

  // Width mapping - only used when size is provided
  double _getWidthForSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.xsmall:
        return 136.0;
      case ButtonSize.small:
        return 162.5;
      case ButtonSize.medium:
        return 178.5;
      case ButtonSize.large:
        return 361.0;
    }
  }

  // Padding mapping - only used when size is provided
  EdgeInsetsGeometry _getPaddingForSize(ButtonSize size) {
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
    if (onPressed == null || isDisabled == true || isSelected == false) {
      return Colors.grey.shade300;
    }
    if (fillcolor != null) return fillcolor!;
    
    switch (variant) {
      case ButtonVariant.primary:
        return Theme.of(context).primaryColor;
      case ButtonVariant.secondary:
        return Colors.grey;
      case ButtonVariant.outline:
      case ButtonVariant.icon:
        return Colors.transparent;
      case ButtonVariant.danger:
        return Colors.red;
      case ButtonVariant.success:
        return Colors.green;
      case ButtonVariant.warning:
        return Colors.orange;
      case ButtonVariant.info:
        return Colors.teal;
      case ButtonVariant.disabled:
        return Colors.grey.shade400;
      case ButtonVariant.fab:
        return Colors.blue;
      case ButtonVariant.link:
        return Colors.blueAccent;
      default:
        return Colors.blue;
    }
  }

  // Text color
  Color _getTextColor(BuildContext context) {
    if (onPressed == null || isDisabled == true) {
      return AppColors.black;
    }

    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.danger:
      case ButtonVariant.success:
      case ButtonVariant.warning:
      case ButtonVariant.info:
      case ButtonVariant.fab:
        return Colors.white;
      case ButtonVariant.link:
        return Colors.blue;
      case ButtonVariant.secondary:
      case ButtonVariant.outline:
      case ButtonVariant.icon:
      default:
        return Colors.black;
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
    final buttonBorderRadius = borderRadius ?? BorderRadius.circular(8.0);
    final isEnabled = !(isDisabled == true || isLoading);
    
    // Determine final dimensions and padding
    final double? finalWidth = width ?? (size != null ? _getWidthForSize(size!) : null);
    final double? finalHeight = height ?? (size != null ? _getHeightForSize(size!) : null);
    final EdgeInsetsGeometry finalPadding = padding ?? 
    (size != null ? _getPaddingForSize(size!) : const EdgeInsets.symmetric(horizontal: 12, vertical: 4));
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: _getBackgroundColor(context),
      foregroundColor: _getTextColor(context),
      padding: finalPadding,
      elevation: variant == ButtonVariant.primary && onPressed != null ? 2 : 0,
      shadowColor: variant == ButtonVariant.primary
          ? Colors.black26
          : Colors.transparent,
      shape: RoundedRectangleBorder(
      borderRadius: buttonBorderRadius,
        side: _getBorderSide(context) ?? BorderSide.none,
      ),
      minimumSize: finalWidth != null || finalHeight != null 
          ? Size(finalWidth ?? 0, finalHeight ?? 0) 
          : Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    final buttonChild = isLoading
        ? SizedBox(
            width: 16,
            height: 16,
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
                const SizedBox(width: 4),
              ],
              CustomText(
                title: title,
                
                style: AppUtils.getThemedTextStyle(
                  context,
                  fontVarient,
                )?.copyWith(color: _getTextColor(context)),
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: 4),
                trailingIcon!,
              ],
            ],
          );

    // If no size constraints provided, return button without SizedBox wrapper
    if (finalWidth == null && finalHeight == null) {
      return ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: buttonStyle,
        child: buttonChild,
      );
    }

    // Otherwise, wrap with SizedBox for size constraints
    return SizedBox(
      width: finalWidth,
      height: finalHeight,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: buttonStyle,
        child: buttonChild,
      ),
    );
  }
}