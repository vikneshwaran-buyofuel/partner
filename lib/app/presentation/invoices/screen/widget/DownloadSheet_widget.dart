import 'package:flutter/material.dart';
import 'package:partner/app/common_widgets/bottomsheet/custom_bottomSheet.dart';
import 'package:partner/app/common_widgets/buttons/CustomButton.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';
import 'package:partner/core/constants/app_colors.dart';
import 'package:partner/core/constants/enum.dart';

class DownloadSheet {
  static showDownloadSheet(BuildContext context) {
    return CustomBottomSheet.show(
      context: context,
      title: "Download",
      showButton: true,
      buttonText: "Export as CSV",
      onButtonPress: () {
        // Handle export logic here
      },
      builder: (ctx, close) {
        return _DownloadList();
      },
    );
  }
}

class _DownloadList extends StatefulWidget {
  @override
  State<_DownloadList> createState() => _DownloadListState();
}

class _DownloadListState extends State<_DownloadList> {
  List<Map<String, dynamic>> columns = [
    {"label": "Seller", "selected": true},
    {"label": "Invoice Date", "selected": false},
    {"label": "Product", "selected": false},
    {"label": "Total Amount", "selected": true},
  ];

  bool selectAll = false;

  void toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (var col in columns) {
        col["selected"] = selectAll;
      }
    });
  }

  void toggleSingle(int index, bool? value) {
    setState(() {
      columns[index]["selected"] = value ?? false;
      // Uncheck selectAll if any column is deselected
      selectAll = columns.every((c) => c["selected"] == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CheckboxListTile(
          value: selectAll,
          onChanged: toggleSelectAll,
          title: CustomText(title: "Select All Columns", variant: TextVariant.bodyMedium),
          controlAffinity: ListTileControlAffinity.leading,
        ),
        const Divider(),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: columns.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final item = columns[index];
            return CheckboxListTile(
              value: item["selected"],
              onChanged: (val) => toggleSingle(index, val),
              controlAffinity: ListTileControlAffinity.leading,
              title: CustomText(
                title: item["label"],
                variant: TextVariant.bodyMedium,
                style: TextStyle(
                  fontWeight: item["selected"] ? FontWeight.w600 : FontWeight.w400,
                  color: AppColors.primary,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
