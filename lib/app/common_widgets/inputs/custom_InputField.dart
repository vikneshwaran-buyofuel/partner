import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partner/core/constants/enum.dart';
import 'package:intl/intl.dart';

class CustomInputField extends StatefulWidget {
  final String? label;
  final InputType inputType;
  final TextEditingController controller;
  final String? errorText;
  final String? hintText;
  final bool? enabled;
  final int? maxLength;
  final int? maxLines;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  const CustomInputField({
    super.key,
    this.label,
    required this.inputType,
    required this.controller,
    this.errorText,
    this.hintText,
    this.enabled = true,
    this.maxLength,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.focusNode,
    this.textInputAction,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;
  String? _internalError;

  @override
  void initState() {
    super.initState();
    // Add listener for real-time validation if validator is provided
    if (widget.validator != null) {
      widget.controller.addListener(_validateInput);
    }
  }

  @override
  void dispose() {
    if (widget.validator != null) {
      widget.controller.removeListener(_validateInput);
    }
    super.dispose();
  }

  void _validateInput() {
    if (widget.validator != null) {
      setState(() {
        _internalError = widget.validator!(widget.controller.text);
      });
    }
  }

  TextInputType _getKeyboardType() {
    switch (widget.inputType) {
      case InputType.number:
        return TextInputType.number;
      case InputType.email:
        return TextInputType.emailAddress;
      case InputType.phone:
        return TextInputType.phone;
      case InputType.url:
        return TextInputType.url;
      case InputType.multiline:
        return TextInputType.multiline;
      case InputType.date:
        return TextInputType.none;
      case InputType.password:
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter>? _getInputFormatters() {
    switch (widget.inputType) {
      case InputType.number:
        return [FilteringTextInputFormatter.digitsOnly];
      case InputType.phone:
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(15),
        ];
      case InputType.email:
        return [
          FilteringTextInputFormatter.deny(RegExp(r'\s')), // No spaces
        ];
      default:
        return null;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      widget.controller.text = formattedDate;
      if (widget.onChanged != null) {
        widget.onChanged!(formattedDate);
      }
    }
  }

  String? _getEffectiveError() {
    // Priority: external error > internal validation error
    return widget.errorText ?? _internalError;
  }

  @override
  Widget build(BuildContext context) {
    bool isPassword = widget.inputType == InputType.password;
    bool isDate = widget.inputType == InputType.date;
    String? effectiveError = _getEffectiveError();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          obscureText: isPassword ? _obscureText : false,
          keyboardType: _getKeyboardType(),
          inputFormatters: _getInputFormatters(),
          maxLength: widget.maxLength,
          maxLines: widget.inputType == InputType.multiline
              ? widget.maxLines
              : 1,
          textInputAction: widget.textInputAction,
          readOnly: isDate,
          onTap: isDate
              ? () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _selectDate(context);
                }
              : null,
          onChanged: widget.onChanged,
          style: TextStyle(color: widget.enabled! ? Colors.black : Colors.grey),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            counterText: '', // Hide character counter
            errorText: effectiveError,
            errorMaxLines: 2,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: effectiveError != null
                    ? Colors.red.shade300
                    : Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: effectiveError != null ? Colors.red : Colors.blue,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade300),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            filled: !widget.enabled!,
            fillColor: widget.enabled! ? null : Colors.grey.shade50,
            suffixIcon: _buildSuffixIcon(isPassword, isDate),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon(bool isPassword, bool isDate) {
    if (isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey.shade600,
        ),
        onPressed: widget.enabled!
            ? () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              }
            : null,
      );
    }

    if (isDate) {
      return Icon(
        Icons.calendar_today,
        color: widget.enabled! ? Colors.grey.shade600 : Colors.grey.shade400,
        size: 20,
      );
    }

    return null;
  }
}
