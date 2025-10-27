import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';
import 'package:partner/app/common_widgets/app_layout/appBar/custom_appBar.dart';
import 'package:partner/app/common_widgets/buttons/CustomButton.dart';
import 'package:partner/app/presentation/ledger/screen/ledger_card.dart';
import 'package:partner/core/constants/app_colors.dart';
import 'package:partner/core/constants/enum.dart';

class LedgerDashPage extends StatefulWidget {
  const LedgerDashPage({super.key});

  @override
  _LedgerDashPageState createState() => _LedgerDashPageState();
}

class _LedgerDashPageState extends State<LedgerDashPage> {
  final List<Widget> actionItems = [
    IconButton(onPressed: () {}, icon: Icon(LucideIcons.fileDown)),
    IconButton(onPressed: () {}, icon: Icon(LucideIcons.funnel)),
  ];
  final List<Map<String, dynamic>> menuItem = [
    {"label": "All", "count": 5},
    {"label": "Payment Made", "count": 30},
    {"label": "Payment Received", "count": 30},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Ledger",
        isLeadinTitle: true,
        backgroundColor: AppColors.divider,
        actions: actionItems,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0 ,vertical: 4),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: menuItem.map((item) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    child: CustomButton(variant: ButtonVariant.success, title: item['label'],onPressed: (){},padding: EdgeInsets.all(10),  trailingIcon: Container(height: 18,width: 18, decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.all(Radius.circular(4))
                    ), child: Center(child: CustomText(fitInContainer: true, title: "13"))),),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            LedgerCard(title: "KLS CASHEW NUT ", badge: "KLS/SL/2526/36", date: "22/12/22033", price: "₹1,25,000.00", onDownload:(){})
          ],
        ),
      ),
    );
  }
}
