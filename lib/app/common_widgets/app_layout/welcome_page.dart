import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partner/app/common_widgets/app_layout/appBar/custom_appBar.dart';
import 'package:partner/app/common_widgets/buttons/CustomButton.dart';
import 'package:partner/app/router/route_constants.dart';
import 'package:partner/core/constants/app_colors.dart';
import 'package:partner/core/constants/enum.dart'; // assuming ButtonVariant, ButtonSize enums

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  void handleClick(BuildContext context, String route) {
  context.go(route);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(showLogo: true ,backgroundColor: AppColors.white,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              // Mockup Image
              Image.asset(
                'assets/welcome.png', // your reference phone image
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 24),

              // Headline
              const Text(
                'Streamline your trades\nwith ease',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              const Text(
                'Get started as Buyofuel Partner',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: 32),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomButton(
                      title: "I’m a Trade Partner",
                       onPressed: () => handleClick(context, RouteConstants.homeRoute),
                      variant: ButtonVariant.primary,
                      size: ButtonSize.medium,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      title: "I’m an Affiliate",
                        onPressed: () => handleClick(context,RouteConstants.loginRoute),
                      variant: ButtonVariant.primary,
                      size: ButtonSize.medium,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Terms & Privacy
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Open Terms
                    },
                    child: const Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Text(
                    '  |  ',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Open Privacy Policy
                    },
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
