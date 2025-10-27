import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partner/core/constants/enum.dart';
import 'package:partner/core/theme/app_theme.dart';

class AppUtils {
  // Network connectivity check
  static Future<bool> hasNetworkConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    return connectivityResult != ConnectivityResult.none;
  }

  // Show a snackbar
  static void showSnackBar(
    BuildContext context, {
    required String message,
    Duration? duration,
    Color? backgroundColor,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 2),
        backgroundColor: backgroundColor,
        action: action,
      ),
    );
  }

  // Show a toast message
  static void showToast(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(duration ?? const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
static TextStyle? getThemedTextStyle(BuildContext context ,TextVariant varient) {
    final textTheme = Theme.of(context).textTheme;
    switch (varient) {
      case TextVariant.displayExtraLarge:
        return textTheme.displayExtraLarge;
      case TextVariant.displayLarge:
        return textTheme.displayLarge;
      case TextVariant.displayMedium:
        return textTheme.displayMedium;
      case TextVariant.displaySmall:
        return textTheme.displaySmall;
      case TextVariant.headlineLarge:
        return textTheme.headlineLarge;
      case TextVariant.headlineMedium:
        return textTheme.headlineMedium;
      case TextVariant.headlineSmall:
        return textTheme.headlineSmall;
      case TextVariant.titleLarge:
        return textTheme.titleLarge;
      case TextVariant.titleMedium:
        return textTheme.titleMedium;
      case TextVariant.titleSmall:
        return textTheme.titleSmall;
      case TextVariant.bodyLarge:
        return textTheme.bodyLarge;
      case TextVariant.bodyMedium:
        return textTheme.bodyMedium;
      case TextVariant.bodySmall:
        return textTheme.bodySmall;
      case TextVariant.labelLarge:
        return textTheme.labelLarge;
      case TextVariant.labelMedium:
        return textTheme.labelMedium;
      case TextVariant.labelSmall:
        return textTheme.labelSmall;
    }
  }

  // Date formatting
  // static String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
  //   return DateFormat(format).format(date);
  // }

  // Time formatting
  static String formatTime(DateTime time, {String format = 'HH:mm'}) {
    return DateFormat(format).format(time);
  }

  // Date and time formatting
  // static String formatDateTime(DateTime dateTime, {String format = 'yyyy-MM-dd HH:mm'}) {
  //   return DateFormat(format).format(dateTime);
  // }

  static String getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    final seconds = diff.inSeconds;

    if (seconds < 60) return 'just now';
    if (seconds < 3600) {
      final minutes = diff.inMinutes;
      return '$minutes minute${minutes > 1 ? 's' : ''} ago';
    }
    if (seconds < 86400) {
      final hours = diff.inHours;
      return '$hours hour${hours > 1 ? 's' : ''} ago';
    }
    if (seconds < 604800) {
      final days = diff.inDays;
      return '$days day${days > 1 ? 's' : ''} ago';
    }
    if (seconds < 2592000) {
      final weeks = (diff.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    }
    if (seconds < 31536000) {
      final months = (diff.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    }

    final years = (diff.inDays / 365).floor();
    return '$years year${years > 1 ? 's' : ''} ago';
  }

  // Email validation
  static bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return emailRegExp.hasMatch(email);
  }

  // Password validation (at least 8 chars, 1 uppercase, 1 lowercase, 1 number)
  static bool isValidPassword(String password) {
    final passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$',
    );
    return passwordRegExp.hasMatch(password);
  }

  // Phone number validation (simple)
  static bool isValidPhoneNumber(String phoneNumber) {
    final phoneRegExp = RegExp(r'^\+?[0-9]{10,15}$');
    return phoneRegExp.hasMatch(phoneNumber);
  }

  // URL validation
  static bool isValidUrl(String url) {
    final urlRegExp = RegExp(
      r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$',
    );
    return urlRegExp.hasMatch(url);
  }

  // Truncate string with ellipsis
  static String truncateString(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  // Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      final kb = bytes / 1024;
      return '${kb.toStringAsFixed(2)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      final mb = bytes / (1024 * 1024);
      return '${mb.toStringAsFixed(2)} MB';
    } else {
      final gb = bytes / (1024 * 1024 * 1024);
      return '${gb.toStringAsFixed(2)} GB';
    }
  }

  // Format currency
  // static String formatCurrency(double amount, {String symbol = '\$', String locale = 'en_US'}) {
  //   return NumberFormat.currency(symbol: symbol, locale: locale).format(amount);
  // }
  static String formatQuantity(double value) {
    // Pattern '#,##,##0.000' formats Indian numbering system with 3 decimals
    final formatter = NumberFormat('#,##,##0.000', 'en_IN');
    return formatter.format(value);
  }

  static String shortenNumber(double amount) {
    final amt = amount.abs();
    final prefix = amount < 0 ? '-' : '';

    if (amt < 1000) {
      return '$prefix${amt.toStringAsFixed(0)}'; // Less than 1000, no suffix
    } else if (amt < 100000) {
      return '$prefix${(amt / 1000).toStringAsFixed(2).replaceAll(RegExp(r'\.0+$'), '')}k'; // Thousands
    } else if (amt < 10000000) {
      return '$prefix${(amt / 100000).toStringAsFixed(2).replaceAll(RegExp(r'\.0+$'), '')}L'; // Lakhs
    } else {
      return '$prefix${(amt / 10000000).toStringAsFixed(2).replaceAll(RegExp(r'\.0+$'), '')}Cr'; // Crores
    }
  }

  // ------------------ Currency ------------------
  static String formatCurrency(double amount, String currency) {
    switch (currency) {
      case 'USD':
        final usd = NumberFormat.currency(locale: 'en_US', symbol: '\$');
        return usd.format(amount);
      case 'INR':
        final inr = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
        return inr.format(amount);
      default:
        return amount.toString();
    }
  }

  // ------------------ Date / DateTime ------------------
  static String formatDate(DateTime date) {
    final formatter = DateFormat('MMM d, y', 'en_IN'); // Oct 24, 2025
    return formatter.format(date);
  }

  static String formatDateTime(DateTime date) {
    final formatter = DateFormat(
      'MMM d, y, h:mm a',
      'en_IN',
    ); // Oct 24, 2025, 1:30 PM
    return formatter.format(date);
  }

  // ------------------ Difference in Days ------------------
  static int differenceInDays(DateTime from, DateTime to) {
    return to.difference(from).inDays;
  }
}
