import 'package:flutter/material.dart';
import 'package:partner/app/presentation/app_layout/appBar/custom_appBar.dart';
import 'package:partner/app/common_widgets/buttons/CustomButton.dart';
import 'package:partner/app/common_widgets/inputs/custom_InputField.dart';
import 'package:partner/core/constants/enum.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  void _onConfirm() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);

    // TODO: Handle forgot password logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reset link sent to email')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '',
        showBack: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "If you’ve forgotten your password, please enter your email to reset it.",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),

              CustomInputField(
                label: 'Email',
                inputType: InputType.email,
                controller: _emailController,
              ),
              const SizedBox(height: 40),

              CustomButton(
                title: 'Confirm',
                onPressed: _onConfirm,
                isLoading: _isLoading,
                variant: ButtonVariant.primary,
                size: ButtonSize.large,
                fullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
