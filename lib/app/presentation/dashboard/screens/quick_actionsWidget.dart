import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';
import 'package:partner/app/common_widgets/buttons/quick_action_btn.dart';
import 'package:partner/core/constants/enum.dart';


class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
   
      
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomText(title:  'Quick Actions',variant: TextVariant.titleMedium),
    
          const SizedBox(height: 32),
          SingleChildScrollView(
          scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                QuickActionButton(
                  icon: LucideIcons.fileText,
                  label: 'Invoices',
                  height: 56,
                  width: 56,
                  borderRadius: 6,
                  onTap: () {
                    // Handle Invoices tap
                    print('Invoices tapped');
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                QuickActionButton(
                  icon: LucideIcons.bookOpen,
                  label: 'Ledger',
                  height: 56,
                  width: 56,
                  borderRadius: 6,
                  onTap: () {
                    // Handle Ledger tap
                    print('Ledger tapped');
                  },
                ),
                   SizedBox(
                  width: 20,
                ),
                QuickActionButton(
                  icon: LucideIcons.settings,
                  label: 'Settings',
                  height: 56,
                  width: 56,
                  borderRadius: 6,
                  onTap: () {
                    // Handle Settings tap
                    print('Settings tapped');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
