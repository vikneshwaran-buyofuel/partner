import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';
import 'package:partner/app/common_widgets/buttons/CustomButton.dart';
import 'package:partner/core/constants/app_colors.dart';
import 'package:partner/core/constants/enum.dart';
import 'package:partner/core/utils/app_utils.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String badge;
  final String description;
  final String date;
  final String price;
  final String quantity;
  final VoidCallback? onDownloadInvoice;
  final VoidCallback? onAddInvoice;

  const ProductCard({
    super.key,
    required this.title,
    required this.badge,
    required this.description,
    required this.date,
    required this.price,
    required this.quantity,
    this.onDownloadInvoice,
    this.onAddInvoice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header section
            Row(
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
                    LucideIcons.package,
                    color: Colors.green[600],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),

                /// Title + badge + description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title + Badge Row
                      Row(
                        children: [
                          Flexible(
                            child: CustomText(
                              title: title,
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
                              title: badge,
                              variant: TextVariant.labelSmall,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      /// Description Row
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: CustomText(
                              title: description,
                              variant: TextVariant.bodyMedium,

                              ellipsis: true,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: Icon(
                              Icons.circle,
                              size: 4,
                              color: Colors.grey[400],
                            ),
                          ),
                          CustomText(
                            title: date,
                            variant: TextVariant.bodyMedium,
                          ),
                          Expanded(
                            child: CustomButton(
                              title: 'Invoice',
                              onPressed: onDownloadInvoice,
                              variant: ButtonVariant.disabled,
                              fillcolor: AppColors.btnGray,
                              leadingIcon: const Icon(
                                LucideIcons.download,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                /// Invoice Button
              ],
            ),

            /// Divider
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Divider(color: Colors.grey[200], height: 1),
            ),

            /// Price & Quantity Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Price and Quantity
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title: AppUtils.formatCurrency(
                        double.parse(price),
                        "INR",
                      ),
                      color: AppColors.success,
                      variant: TextVariant.labelLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.circle,
                        size: 4,
                        color: Colors.green[700],
                      ),
                    ),
                    CustomText(title: quantity,variant: TextVariant.labelMedium, color: AppColors.success,),
                  ],
                ),

                /// Add Invoice Button
                CustomButton(
                  title: 'Add Invoice',
                  onPressed: onAddInvoice,
                 
                  variant: ButtonVariant.primary,
                  size: ButtonSize.small,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
