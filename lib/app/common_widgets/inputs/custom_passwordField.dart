import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? padding;
  final bool showValidationRules;
  final bool enableValidation;

  const CustomPasswordField({
    super.key,
    this.controller,
    this.labelText = 'Password',
    this.hintText,
    this.onChanged,
    this.padding,
    this.showValidationRules = false,
    this.enableValidation = true,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _isObscured = true;
  String _password = '';

  bool get _hasMinLength => _password.length >= 8;
  bool get _hasUppercase => _password.contains(RegExp(r'[A-Z]'));
  bool get _hasNumber => _password.contains(RegExp(r'[0-9]'));

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  void _onPasswordChanged(String value) {
    setState(() {
      _password = value;
    });
    widget.onChanged?.call(value);
  }

  String? _validatePassword(String? value) {
    if (!widget.enableValidation) return null;
    
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain an uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain a number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: widget.padding,
          child: TextFormField(
            controller: widget.controller,
            obscureText: _isObscured,
            onChanged: _onPasswordChanged,
            validator: _validatePassword,
            decoration: InputDecoration(
              labelText: widget.labelText,
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey.shade600,
                ),
                onPressed: _toggleVisibility,
              ),
            ),
          ),
        ),
        if (widget.showValidationRules) ...[
          const SizedBox(height: 12),
          _buildValidationRule('Minimum 8 characters.', _hasMinLength),
          const SizedBox(height: 8),
          _buildValidationRule(
              'At least one uppercase letter (A-Z).', _hasUppercase),
          const SizedBox(height: 8),
          _buildValidationRule('At least one number (0-9).', _hasNumber),
        ],
      ],
    );
  }

  Widget _buildValidationRule(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.close,
          color: isValid ? Colors.green : Colors.red,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: isValid ? Colors.green : Colors.red,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
