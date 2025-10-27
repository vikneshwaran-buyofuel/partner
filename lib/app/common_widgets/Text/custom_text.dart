import 'package:flutter/material.dart';
import 'package:partner/core/constants/enum.dart';
import 'package:partner/core/theme/app_theme.dart';

class CustomText extends StatelessWidget {
  final String? title;
  final TextVariant? variant;
  final TextAlign? textAlign;
  final bool ellipsis;
  final int? maxLines;
  final Color? color;
  final TextStyle? style;
  final bool fitInContainer;

  const CustomText({
    super.key,
    required this.title,
    this.variant,
    this.textAlign,
    this.ellipsis = false,
    this.color,
    this.maxLines,
    this.style,
    this.fitInContainer = false,
  });

  TextStyle? _getThemedTextStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    switch (variant) {
      case TextVariant.displayExtraLarge:
        return textTheme.displayExtraLarge;
      case TextVariant.displayLarge:
        return textTheme.displayLarge;
      case TextVariant.displayMedium:
        return textTheme.displayMedium;
      case TextVariant.displaySmall:
        return textTheme.displaySmall;
      case TextVariant.headlineLarge:
        return textTheme.headlineLarge;
      case TextVariant.headlineMedium:
        return textTheme.headlineMedium;
      case TextVariant.headlineSmall:
        return textTheme.headlineSmall;
      case TextVariant.titleLarge:
        return textTheme.titleLarge;
      case TextVariant.titleMedium:
        return textTheme.titleMedium;
      case TextVariant.titleSmall:
        return textTheme.titleSmall;
      case TextVariant.bodyLarge:
        return textTheme.bodyLarge;
      case TextVariant.bodyMedium:
        return textTheme.bodyMedium;
      case TextVariant.bodySmall:
        return textTheme.bodySmall;
      case TextVariant.labelLarge:
        return textTheme.labelLarge;
      case TextVariant.labelMedium:
        return textTheme.labelMedium;
      case TextVariant.labelSmall:
        return textTheme.labelSmall;
      default:
        return textTheme.bodyMedium;
    }
  }

  Alignment _getAlignment(TextAlign? align) {
    switch (align) {
      case TextAlign.left:
      case TextAlign.start:
        return Alignment.centerLeft;
      case TextAlign.right:
      case TextAlign.end:
        return Alignment.centerRight;
      case TextAlign.center:
        return Alignment.center;
      default:
        return Alignment.centerLeft;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (title == null || title!.trim().isEmpty) return const SizedBox.shrink();
    final mergedStyle = _getThemedTextStyle(context)?.merge(style) ?? style;
    final effectiveStyle = mergedStyle!.copyWith(color: color);
    final textWidget = Text(
      title!,
    
      style: effectiveStyle,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: ellipsis ? maxLines : null,
      overflow: ellipsis ? TextOverflow.ellipsis : null,
    );

    // Wrap with FittedBox if font size should fit container
    if (fitInContainer) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        alignment: _getAlignment(textAlign),
        child: textWidget,
      );
    }

    return textWidget;
  }
}
