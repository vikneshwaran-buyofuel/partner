import 'package:flutter/material.dart';

class LedgerDashPage extends StatefulWidget {
  const LedgerDashPage({ super.key });

  @override
  _LedgerDashPageState createState() => _LedgerDashPageState();
}

class _LedgerDashPageState extends State<LedgerDashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('Ledger Dashboard Page'),
      ),
      
    );
  }
}