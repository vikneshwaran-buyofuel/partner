import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({ super.key });

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text('Settings Page'),
      ),
      
    );
  }
}