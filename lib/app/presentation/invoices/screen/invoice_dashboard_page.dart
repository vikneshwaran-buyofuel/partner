import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';
import 'package:partner/app/common_widgets/app_layout/appBar/custom_appBar.dart';
import 'package:partner/app/common_widgets/buttons/CustomButton.dart';
import 'package:partner/app/common_widgets/bottomsheet/custom_bottomSheet.dart';
import 'package:partner/app/common_widgets/inputs/custom_InputField.dart';
import 'package:partner/app/presentation/dashboard/screens/product_card.dart';
import 'package:partner/app/presentation/invoices/screen/widget/DownloadSheet_widget.dart';
import 'package:partner/app/router/route_constants.dart';
import 'package:partner/core/constants/app_colors.dart';
import 'package:partner/core/constants/app_constants.dart';
import 'package:partner/core/constants/enum.dart';
import 'package:go_router/go_router.dart';

class InvoiceDashPage extends StatefulWidget {
  const InvoiceDashPage({super.key});

  @override
  _InvoiceDashPageState createState() => _InvoiceDashPageState();
}

class _InvoiceDashPageState extends State<InvoiceDashPage> {
  void addInvoice(BuildContext context) {
    GoRouter.of(context).go(RouteConstants.addInvoiceRoute);
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Define actionItems *inside* build(), so context is valid
    final List<Widget> actionItems = [
      IconButton(onPressed:()=> DownloadSheet.showDownloadSheet(context), icon: const Icon(LucideIcons.fileDown)),
      IconButton(
        onPressed: () => _showFilterSheet(context),
        icon: const Icon(LucideIcons.funnel),
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: "Invoices",
        isLeadinTitle: true,
        backgroundColor: AppColors.divider,
        actions: actionItems,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12.0),
        child: Column(
          children: [
            // Horizontal Scroll Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: AppConstants.invoiceStatus
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: CustomButton(
                          title: item,
                          isSelected: true,
                          onPressed: () {},
                          variant: ButtonVariant.success,
                          trailingIcon: Container(
                            height: 20,
                            width: 25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Center(
                              child: Text(
                                "10",
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
            Expanded(
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
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ProductCard(
                      title: 'KLS CASHEW NUT',
                      badge: 'KLS/SL/2526/36',
                      description: 'Cashew Nutshell (Raw) (5%)',
                      onDownloadInvoice: () {},
                      date: '12 Aug 2023',
                      price: '120000',
                      quantity: '2000 Kgs',
                      onAddInvoice: () => addInvoice(context),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Keep bottom sheet outside as a separate function
void _showFilterSheet(BuildContext context) {
  final TextEditingController start_dateCtl = TextEditingController();

  CustomBottomSheet.show(
    context: context,
    title: "Filter Invoices",
    buttonText: "Apply Filter",
    onButtonPress: () {
      Navigator.pop(context);
    },
    builder: (ctx, close) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(title: "Product", variant: TextVariant.titleMedium),
              SizedBox(
                width: 162.5,
                child: CustomInputField(
                  enabled: true,
                  hintText: "Select Product",
                  inputType: InputType.string,
                  controller: start_dateCtl,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(title: "Seller", variant: TextVariant.titleMedium),
              SizedBox(
                width: 162.5,
                child: CustomInputField(
                  enabled: true,
                  hintText: "Select Seller",
                  inputType: InputType.string,
                  controller: start_dateCtl,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 162.5,
                child: CustomInputField(
                  label: "Invoice Date",
                  hintText: "Start Date",
                  inputType: InputType.date,
                  controller: start_dateCtl,
                ),
              ),

              SizedBox(
                width: 162.5,
                child: CustomInputField(
                  label: "",
                  hintText: "End Date",
                  inputType: InputType.date,
                  controller: start_dateCtl,
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

