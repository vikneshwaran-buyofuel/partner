import 'package:flutter/material.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';
import 'package:partner/core/constants/app_colors.dart';
import 'package:partner/core/constants/enum.dart';

class ContactCard extends StatefulWidget {
  final String? header;
  final String title;
  final String? subtitle;
  final String? description;
  final Widget? leadingIcon;
  final Color leadingColor;
  final Widget? trailingIcon;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback? onTap;
  final Color? selectedColor;
  final double minHeight;
  final double maxHeight;

  const ContactCard({
    Key? key,
    this.header,
    required this.title,
    this.subtitle,
    this.description,
    this.leadingColor = AppColors.black,
    this.leadingIcon,
    this.trailingIcon,
    this.isSelected = false,
    this.isDisabled = false,
    this.onTap,
    this.selectedColor,
    this.minHeight = 69,
    this.maxHeight = 150,
  }) : super(key: key);

  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.isSelected;
  }

  void _handleTap() {
    if (!widget.isDisabled) {
      setState(() {
        _isSelected = !_isSelected;
      });
      if (widget.onTap != null) {
        widget.onTap!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultSelectedColor =
        widget.selectedColor ?? const Color.fromARGB(255, 194, 224, 245);

    Color backgroundColor = Colors.white;
    if (widget.isDisabled) {
      backgroundColor = Colors.grey.shade300;
    } else if (_isSelected) {
      backgroundColor = defaultSelectedColor;
    }

    return Card(
      elevation: widget.isDisabled ? 0 : 2,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _isSelected && !widget.isDisabled ? Colors.blue : Colors.grey.shade300,
          width: _isSelected && !widget.isDisabled ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: _handleTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: BoxConstraints(
            minHeight: widget.minHeight,
            maxHeight: widget.maxHeight,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.header != null) ...[
                Text(
                  widget.header!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: widget.isDisabled ? Colors.grey.shade600 : Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
              ],
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.leadingIcon != null) ...[
                      Opacity(
                        opacity: widget.isDisabled ? 0.5 : 1.0,
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: widget.leadingColor.withOpacity(0.05),
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: IconTheme(
                            data: IconThemeData(color: widget.leadingColor),
                            child: widget.leadingIcon!,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: widget.title,
                            variant: TextVariant.titleSmall,
                            style: const TextStyle(fontSize: 22),
                          ),
                          if (widget.subtitle != null) ...[
                            const SizedBox(height: 2),
                            CustomText(
                              title: widget.subtitle,
                              variant: TextVariant.labelMedium,
                            ),
                          ],
                          if (widget.description != null) ...[
                            const SizedBox(height: 2),
                            CustomText(
                              title: widget.description,
                              ellipsis: true,
                              maxLines: 1,
                              variant: TextVariant.labelMedium,
                              style: const TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (widget.trailingIcon != null) ...[
                      const SizedBox(width: 8),
                      Opacity(
                        opacity: widget.isDisabled ? 0.5 : 1.0,
                        child: widget.trailingIcon!,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}