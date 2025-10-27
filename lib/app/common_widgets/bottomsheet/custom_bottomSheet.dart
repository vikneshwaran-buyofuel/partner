import 'package:flutter/material.dart';
import 'package:partner/app/common_widgets/buttons/CustomButton.dart';
import 'package:partner/core/constants/enum.dart';

class CustomBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget Function(BuildContext context, VoidCallback close) builder,
    String? buttonText,
    VoidCallback? onButtonPress,
    bool showButton = true,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      builder: (ctx) {
        void close() => Navigator.pop(ctx);

        return _CustomBottomSheetContent(
          title: title,
          buttonText: buttonText,
          onButtonPress: onButtonPress,
          showButton: showButton,
          onClose: close,
          body: builder(ctx, close),
        );
      },
    );
  }
}

class _CustomBottomSheetContent extends StatelessWidget {
  final String title;
  final Widget body;
  final String? buttonText;
  final VoidCallback? onButtonPress;
  final VoidCallback onClose;
  final bool showButton;

  const _CustomBottomSheetContent({
    Key? key,
    required this.title,
    required this.body,
    required this.onClose,
    this.buttonText,
    this.onButtonPress,
    this.showButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),

            // title + close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: onClose,
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.close, size: 22),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Flexible(
              child: SingleChildScrollView(child: body),
            ),

            if (showButton && buttonText != null) ...[
              const SizedBox(height: 20),
              CustomButton(title: buttonText!, onPressed: onButtonPress,size: ButtonSize.large, variant: ButtonVariant.primary,borderRadius: BorderRadius.circular(12))
            ],
          ],
        ),
      ),
    );
  }
}
