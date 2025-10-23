import 'package:flutter/material.dart';

void showMySnackBar(BuildContext context, String message, {Key? key}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      key: key ?? const Key('mySnackBar'), // default key if none provided
      content: Text(message),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating, // optional: floating above content
      margin: const EdgeInsets.all(16),
    ),
  );
}
