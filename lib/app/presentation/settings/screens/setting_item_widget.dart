import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';
import 'package:partner/core/constants/enum.dart';

class SettingItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;
  final bool showArrow;

  const SettingItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
    this.iconColor,
    this.showArrow = true,
  });

  @override
  State<SettingItem> createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14,),
          child: Row(
            children: [
              Icon(
                widget.icon,
                size: 24,
                color: widget.iconColor ?? const Color(0xFF4CAF50),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomText(
                   title:widget.title,
                  variant: TextVariant.labelSmall,
                ),
              ),
              if (widget.showArrow)
                Icon(
                  LucideIcons.chevronRight,
                  size: 20,
                  color: Colors.grey[400],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
