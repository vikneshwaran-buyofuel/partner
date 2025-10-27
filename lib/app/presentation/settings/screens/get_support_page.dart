import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:partner/app/common_widgets/app_layout/appBar/custom_appBar.dart';
import 'package:partner/app/common_widgets/cards/contact_card.dart';
import 'package:partner/core/constants/app_colors.dart';

class GetSupportPage extends StatelessWidget {
   GetSupportPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> users = [
    {
      "name": "Rohit Sharma",
      "email": "rohit.sharma@supplyco.com",
      "phone": "+91 9876543210",
      "role": "Supply Chain"
    },
    {
      "name": "Anjali Mehta",
      "email": "anjali.mehta@accounts.com",
      "phone": "+91 9823456789",
      "role": "Account"
    },
    {
      "name": "Vikas Nair",
      "email": "vikas.nair@support.app",
      "phone": "+91 9811122233",
      "role": "App Support"
    },
    {
      "name": "Sneha Kapoor",
      "email": "sneha.kapoor@supplyco.com",
      "phone": "+91 9908765432",
      "role": "Supply Chain"
    },
    {
      "name": "Rahul Jain",
      "email": "rahul.jain@accounts.com",
      "phone": "+91 9789012345",
      "role": "Account"
    },
    {
      "name": "Priya Menon",
      "email": "priya.menon@support.app",
      "phone": "+91 9756677889",
      "role": "App Support"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Get Support", showBack: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: users.map((user) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: ContactCard(
                leadingIcon: Icon(LucideIcons.user),
                leadingColor: AppColors.success,
                title: user['phone'],
                subtitle: user['email'],
                description: "${user['name']} - ${user['role']}",
                trailingIcon: Icon(LucideIcons.chevronRight),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
