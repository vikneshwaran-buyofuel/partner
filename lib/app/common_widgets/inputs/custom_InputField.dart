import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partner/core/constants/enum.dart';


class CustomInputField extends StatefulWidget {
  final String label;
  final InputType inputType;
  final TextEditingController controller;

  const CustomInputField({
    super.key,
    required this.label,
    required this.inputType,
    required this.controller,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;

  TextInputType _getKeyboardType() {
    switch (widget.inputType) {
      case InputType.number:
        return TextInputType.number;
      case InputType.email:
        return TextInputType.emailAddress;
      case InputType.password:
      case InputType.string:
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter>? _getInputFormatters() {
    if (widget.inputType == InputType.number) {
      return [FilteringTextInputFormatter.digitsOnly];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    bool isPassword = widget.inputType == InputType.password;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          obscureText: isPassword ? _obscureText : false,
          keyboardType: _getKeyboardType(),
          inputFormatters: _getInputFormatters(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
