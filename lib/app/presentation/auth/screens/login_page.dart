import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partner/app/common_widgets/app_layout/appBar/custom_appBar.dart';
import 'package:partner/app/common_widgets/buttons/CustomButton.dart';
import 'package:partner/app/common_widgets/inputs/custom_InputField.dart';
import 'package:partner/app/router/route_constants.dart';

import 'package:partner/core/constants/enum.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _onContinue() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Login clicked')));
  }

  void handleNavigate(BuildContext context, String route) {
    context.push(route);
  }

  void handleOtpPage(BuildContext context, String route) {
    GoRouter.of(
      context,
    ).push(RouteConstants.otpVerificationRoute, extra: 'user@example.com');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBack: true,
        showLogo: true,
        
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

            
              const SizedBox(height: 20),

              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                'Enter your email and password to log in.',
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              const SizedBox(height: 30),

              CustomInputField(
                label: 'Email',
                inputType: InputType.email,
                controller: _emailController,
              ),
              const SizedBox(height: 20),

              CustomInputField(
                label: 'Password',
                inputType: InputType.password,
                controller: _passwordController,
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: InkWell(
                    onTap: () => handleNavigate(
                      context,
                      RouteConstants.forgotPasswordRoute,
                    ),
                    child: const Text(
                      'Forgot  Password?',
                      style: TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              CustomButton(
                title: 'Continue',
                onPressed: () =>
                    handleNavigate(context, RouteConstants.newPasswordRoute),
                isLoading: _isLoading,
                variant: ButtonVariant.primary,
                size: ButtonSize.large,
               
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {},
                child: InkWell(
                  onTap: () => handleOtpPage(
                    context,
                    RouteConstants.otpVerificationRoute,
                  ),
                  child: const Text(
                    'Sign In with OTP',
                    style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
