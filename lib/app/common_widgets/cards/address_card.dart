import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';
import 'package:partner/core/constants/app_colors.dart';
import 'package:partner/core/constants/enum.dart';

class AddressCard extends StatelessWidget {
  final String title;
  final String companyName;
  final String address;
  final String gstNumber;

  const AddressCard({
    Key? key,
    required this.title,
    required this.companyName,
    required this.address,
    required this.gstNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            LucideIcons.mapPin,
            color: Colors.green,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: title,
                  variant: TextVariant.titleMedium,
                ),
                const SizedBox(height: 4),
                CustomText(
                  title: companyName,
                  variant: TextVariant.titleMedium,
                  ellipsis: true,
                ),
                const SizedBox(height: 2),
                CustomText(
                  title: address,
                  variant: TextVariant.labelSmall,
                  fitInContainer: true,
                ),
                const SizedBox(height: 4),
                CustomText(
                  title: gstNumber,
                  variant: TextVariant.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
