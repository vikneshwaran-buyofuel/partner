import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';
import 'package:partner/app/common_widgets/buttons/CustomButton.dart';
import 'package:partner/app/common_widgets/app_layout/appBar/custom_appBar.dart';
import 'package:partner/app/common_widgets/cards/contact_card.dart';
import 'package:partner/app/presentation/dashboard/screens/financial_overview.dart';
import 'package:partner/app/presentation/dashboard/screens/product_card.dart';
import 'package:partner/app/presentation/dashboard/screens/quick_actionsWidget.dart';
import 'package:partner/app/common_widgets/buttons/quick_action_btn.dart';
import 'package:partner/core/constants/app_colors.dart';
import 'package:partner/core/constants/enum.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, dynamic>> invoiceStatus = [
    {"label": "To be Invoiced", "count": 15, "isEnabled": true},
    {"label": "To be Paid", "count": 15, "isEnabled": false},
    {"label": "To be Collected", "count": 15, "isEnabled": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBack: false,
        showLogo: true,
        isLeadingLogo: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👋 Greeting
            CustomText(title: "Welcome Back, vicky",variant: TextVariant.titleLarge, )
            ,
            const SizedBox(height: 6),
            CustomText(title:  "Here is an overview of your Business",variant: TextVariant.labelLarge,color: AppColors.grey500, ),
            // Text(
            //   "Here is an overview of your Business",
            //   style: Theme.of(
            //     context,
            //   ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
            // ),
            const SizedBox(height: 20),

            // 📊 Dashboard Cards
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _dashboardTile(
                          context,
                          title: "To be Invoiced",
                          value: "10 Shipments",
                          icon: Icons.receipt_long,
                          border: true,
                        ),
                      ),
                      Expanded(
                        child: _dashboardTile(
                          context,
                          title: "To be Paid",
                          value: "2 Invoices",
                          icon: Icons.payments_outlined,
                          border: true,
                        ),
                      ),
                    ],
                  ),
                  _dashboardTile(
                    context,
                    title: "To be Collected",
                    value: "12 Outstanding Invoices",
                    icon: Icons.check_circle_outline,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔘 Invoice Status Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: invoiceStatus
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CustomButton(
                          title: item['label'] as String,
                          isSelected: item['isEnabled'] as bool,
                          onPressed: () {},
                          variant: ButtonVariant.success,
                          size: ButtonSize.small,
                          trailingIcon: Container(
                            height: 20,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: Text(
                                item['count'].toString(),
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 20),

            // 🛍 Product List with fixed height and scrollable
          Container(
  height: 300, // Set your desired fixed height
  child: ListView.builder(
    itemCount: 10,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05), // Light shadow
              blurRadius: 8,
              offset: const Offset(0, 3), // Slight downward shadow
            ),
          ],
        ),
        child: ProductCard(
          title: 'KLS CASHEW NUT',
          badge: 'KLS/SL/2526/36',
          description: 'Cashew Nutshell (Raw) (5%)',
          onDownloadInvoice: () {
            // Handle invoice download
          },
          date: '12 Aug 2023',
          price: '120000',
          quantity: '2000 Kgs',
          onAddInvoice: () {
            // Handle add invoice
          },
        ),
      );
    },
  ),
),
            
             FinancialOverview(
        utilised: 53.53,
        total: 75.00,
        profitsEarned: 2.80,
        unrealisedProfits: 1.55,
        onViewFullFinancials: () {
          print('View Full Financials tapped');
        },
      ),
              QuickActionsWidget(),
              ContactCard(title:"Call Support", description: "get Support for your questions",leadingColor: AppColors.success, leadingIcon:Icon(LucideIcons.phone),trailingIcon: Icon(LucideIcons.chevronRight), )

          ],
        ),
      ),
    );
  }
}

// 🧩 Dashboard Tile Widget
Widget _dashboardTile(
  BuildContext context, {
  required String title,
  required String value,
  required IconData icon,
  bool border = false,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    decoration: BoxDecoration(
      border: border
          ? Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2)))
          : null,
    ),
    child: Row(
      children: [
        Icon(icon, size: 26, color: AppColors.greyBlue),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    ),
  );
}
