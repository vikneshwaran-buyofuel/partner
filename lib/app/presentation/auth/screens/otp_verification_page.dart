import 'dart:async';
import 'package:flutter/material.dart';
import 'package:partner/app/presentation/app_layout/appBar/custom_appBar.dart';
import 'package:partner/app/common_widgets/buttons/CustomButton.dart';
import 'package:partner/app/common_widgets/inputs/custom_otp_input.dart';

import 'package:partner/core/constants/enum.dart';
class OtpVerificationPage extends StatefulWidget {
  final String email;
  const OtpVerificationPage({super.key, required this.email});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  String _otpValue = '';
  bool _isLoading = false;
  int _secondsRemaining = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  void _onConfirm() async {
    if (_otpValue.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 4-digit OTP')),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isLoading = false);

    // TODO: API validation logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP $_otpValue verified successfully')),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
                'Enter OTP',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Enter the 4-digit OTP code that we sent to\n',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    TextSpan(
                      text: widget.email,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Center(
                child: CustomOtpInput(
                  length: 4,
                  onCompleted: (otp) {
                    setState(() {
                      _otpValue = otp;
                    });
                  },
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
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
