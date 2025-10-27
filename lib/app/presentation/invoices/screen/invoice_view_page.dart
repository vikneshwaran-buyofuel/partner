import 'package:flutter/material.dart';
import 'package:partner/app/common_widgets/app_layout/appBar/custom_appBar.dart';

class InvoiceViewPage extends StatefulWidget {
  const InvoiceViewPage({ Key? key }) : super(key: key);

  @override
  _InvoiceViewPageState createState() => _InvoiceViewPageState();
}

class _InvoiceViewPageState extends State<InvoiceViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "BFD10041",
      ),
      body: Column(
        children: [],
      ),
    );
  }
}