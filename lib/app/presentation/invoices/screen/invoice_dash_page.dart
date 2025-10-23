import 'package:flutter/material.dart';

class InvoiceDashPage extends StatefulWidget {
  const InvoiceDashPage({ super.key });

  @override
  _InvoiceDashPageState createState() => _InvoiceDashPageState();
}

class _InvoiceDashPageState extends State<InvoiceDashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('Invoice Dashboard Page'),
      ),
      
    );
  }
}