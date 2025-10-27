import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';
import 'package:partner/app/common_widgets/buttons/CustomButton.dart';
import 'package:partner/core/constants/app_colors.dart';
import 'package:partner/core/constants/enum.dart';

class LedgerCard extends StatefulWidget {
  final String title;
  final String badge;
  final String price;
  final String date;
  final VoidCallback onDownload;
  const LedgerCard({
    Key? key,
    required this.title,
    required this.badge,
    required this.date,
    required this.price,
    required this.onDownload,
  }) : super(key: key);

  @override
  _LedgerCardState createState() => _LedgerCardState();
}

class _LedgerCardState extends State<LedgerCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              LucideIcons.arrowUpRight,
              color: Colors.green[600],
              size: 24,
            ),
          ),
          const SizedBox(width: 12),

          /// Title + badge + description (takes available space)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title + Badge Row
                Row(
                  children: [
                    Flexible(
                      child: CustomText(
                        title: widget.title,
                        variant: TextVariant.titleSmall,
                        ellipsis: true,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: CustomText(
                        title: widget.badge,
                        variant: TextVariant.labelSmall,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                /// Description Row
                Wrap(
                  spacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    CustomText(
                      title: widget.price,
                      variant: TextVariant.labelLarge,
                      style: TextStyle(color: AppColors.success),
                    ),
                    Icon(Icons.circle, size: 4, color: Colors.grey[400]),
                    CustomText(
                      title: widget.date,
                      variant: TextVariant.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          /// Invoice Button
          CustomButton(
            title: 'Invoice',
            onPressed: widget.onDownload,
            variant: ButtonVariant.disabled,
            fillcolor: AppColors.btnGray,

            leadingIcon: const Icon(LucideIcons.download, size: 16),
          ),
        ],
      ),
    );
  }
}
