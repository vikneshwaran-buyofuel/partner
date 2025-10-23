import 'package:flutter/material.dart';
import 'package:partner/app/presentation/app_layout/appBar/custom_appBar.dart';
import 'package:partner/core/theme/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({ super.key });

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBack: false, showLogo: true,isLeadingLogo: true,),
      body: Column(
        children: [
            Text(
              'Dashboard Screen',
              style: Theme.of(context).textTheme.displayLarge,
            ),

          
        ],
      ),
    );
  }
}