import 'package:flutter/material.dart';
import 'package:partner/app/presentation/dashboard/screens/DashboardScreen.dart';
import 'package:partner/app/presentation/invoices/screen/invoice_dashboard_page.dart';
import 'package:partner/app/presentation/ledger/screen/ledger_dash_page.dart';
import 'package:partner/app/presentation/settings/screens/settings_page.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
   DashboardScreen(),
   InvoiceDashPage(),
   LedgerDashPage(),
   SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    final Color activeColor = Colors.black;
    final Color inactiveColor = Colors.grey.shade400;

    return Scaffold(
      body: Center(child:_pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: activeColor,
        unselectedItemColor: inactiveColor,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Invoices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Ledger',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
