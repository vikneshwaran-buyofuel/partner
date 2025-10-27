import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';
import 'package:partner/app/common_widgets/app_layout/appBar/custom_appBar.dart';
import 'package:partner/app/common_widgets/cards/contact_card.dart';
import 'package:partner/app/common_widgets/inputs/custom_InputField.dart';
import 'package:partner/app/router/route_constants.dart';
import 'package:partner/core/constants/app_colors.dart';
import 'package:partner/core/constants/enum.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:partner/core/utils/app_utils.dart';

class AddInvoicePage extends StatefulWidget {
  const AddInvoicePage({Key? key}) : super(key: key);

  @override
  _AddInvoicePageState createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  final TextEditingController invoiceNoCntl = TextEditingController();
  final TextEditingController invoiceDateCntl = TextEditingController();
  final TextEditingController eWayBillNoCntl = TextEditingController();
  final TextEditingController eWayBillDateCntl = TextEditingController();

  File? invoiceAttachment;
  File? eWayBillAttachment;

  @override
  void dispose() {
    invoiceNoCntl.dispose();
    invoiceDateCntl.dispose();
    eWayBillNoCntl.dispose();
    eWayBillDateCntl.dispose();
    super.dispose();
  }

  Future<void> _pickFile(bool isInvoice) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        setState(() {
          if (isInvoice) {
            invoiceAttachment = File(result.files.single.path!);
          } else {
            eWayBillAttachment = File(result.files.single.path!);
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking file: $e')));
    }
  }

  void _handleContinue() {
    String? errorMessage;

    // Validate all required fields
    if (invoiceNoCntl.text.isEmpty) {
      errorMessage = "Please enter Invoice Number";
    } else if (invoiceDateCntl.text.isEmpty) {
      errorMessage = "Please select Invoice Date";
    } else if (eWayBillNoCntl.text.isEmpty) {
      errorMessage = "Please enter E-Way Bill Number";
    } else if (eWayBillDateCntl.text.isEmpty) {
      errorMessage = "Please select E-Way Bill Date";
    }
    // Show error if found
    if (errorMessage != null) {
      AppUtils.showSnackBar(context, message: errorMessage);
    
    } else {
      GoRouter.of(context).go(RouteConstants.getSupportRoute);
    }
      GoRouter.of(context).go(RouteConstants.getSupportRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Invoice / BFD10041", showBack: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ContactCard(
                title: "KLS CASHEW NUT ",
                description: "KLS/SL/2526/36 • 8 Sep 2025",
                leadingIcon: const Icon(LucideIcons.package),
                leadingColor: AppColors.success,
                trailingIcon: const Icon(LucideIcons.chevronDown),
              ),
              const SizedBox(height: 24),
              _buildInvoiceSection(),
              const SizedBox(height: 24),
              _buildEWayBillSection(),
              const SizedBox(height: 32),
              _buildContinueButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(title: "Invoice"),
          const SizedBox(height: 16),
          CustomInputField(
            label: "Invoice No",
            inputType: InputType.string,
            controller: invoiceNoCntl,
            hintText: "Required",
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomInputField(
                  label: "Invoice Date",
                  inputType: InputType.date,
                  controller: invoiceDateCntl,
                  hintText: "Select Date",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFilePickerField(
                  label: "Invoice Attachment",
                  onTap: () => _pickFile(true),
                  file: invoiceAttachment,
                ),
              ),
            ],
          ),
          if (invoiceAttachment != null) ...[
            const SizedBox(height: 12),
            _buildAttachmentPreview(invoiceAttachment!, true),
          ],
        ],
      ),
    );
  }

  Widget _buildEWayBillSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(title: "E-Way Bill"),
          const SizedBox(height: 16),
          CustomInputField(
            label: "E-Way Bill No",
            inputType: InputType.string,
            controller: eWayBillNoCntl,
            hintText: "Required",
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomInputField(
                  label: "E-Way Bill Date",
                  inputType: InputType.date,
                  controller: eWayBillDateCntl,
                  hintText: "Select Date",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFilePickerField(
                  label: "E-Way Bill Attachment",
                  onTap: () => _pickFile(false),
                  file: eWayBillAttachment,
                ),
              ),
            ],
          ),
          if (eWayBillAttachment != null) ...[
            const SizedBox(height: 12),
            _buildAttachmentPreview(eWayBillAttachment!, false),
          ],
        ],
      ),
    );
  }

  Widget _buildFilePickerField({
    required String label,
    required VoidCallback onTap,
    File? file,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    file != null ? "File Selected" : "Choose File",
                    style: TextStyle(
                      color: file != null ? Colors.black : Colors.grey.shade400,
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(LucideIcons.upload, color: Colors.grey.shade600, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttachmentPreview(File file, bool isInvoice) {
    String fileName = file.path.split('/').last;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(LucideIcons.file, color: Colors.blue, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  isInvoice ? "Invoice" : "E-Way Bill",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(LucideIcons.download, size: 20),
            onPressed: () {
              // Handle download/view
            },
            color: Colors.grey.shade600,
          ),
          IconButton(
            icon: Icon(LucideIcons.x, size: 20),
            onPressed: () {
              setState(() {
                if (isInvoice) {
                  invoiceAttachment = null;
                } else {
                  eWayBillAttachment = null;
                }
              });
            },
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _handleContinue,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          "Continue",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
