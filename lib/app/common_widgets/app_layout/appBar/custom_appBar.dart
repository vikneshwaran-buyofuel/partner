import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partner/core/constants/app_colors.dart';
import 'package:partner/core/constants/enum.dart';
import 'package:partner/core/utils/app_utils.dart';
import 'package:partner/app/common_widgets/Text/custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBack;
  final bool showLogo;
  final bool isLeadingLogo;
  final bool isLeadinTitle;
  final List<Widget>? actions;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final Color? iconColor;
  final TextVariant titleVarient;
  final double elevation;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBack = false,
    this.showLogo = false,
    this.isLeadingLogo = false,
    this.isLeadinTitle = false,
    this.actions,
    this.onBack,
    this.backgroundColor,
    this.iconColor,
    this.titleVarient = TextVariant.headlineSmall,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = AppUtils.getThemedTextStyle(context, titleVarient);

    Widget? leadingWidget;
    Widget? titleWidget;
    // Handle back button
    if (showBack) {
      leadingWidget = IconButton(
        icon: Icon(Icons.arrow_back, color: iconColor ?? Colors.black),
        onPressed:
            onBack ??
            () {
              if (GoRouter.of(context).canPop()) {
                context.pop();
              } else {
                AppUtils.showSnackBar(
                  context,
                  message: "No previous page to go back to",
                );
              }
            },
      );
    }

    // Determine main content (Text or Logo)
    Widget? contentWidget;
    if ((title != null && title!.isNotEmpty)) {
      contentWidget = CustomText(title: title, style: textStyle);
    } else if (showLogo || isLeadingLogo) {
      contentWidget = Image.asset(
        'assets/logo.png',
        height: 40,
        width: isLeadingLogo ? 119 : null,
        fit: BoxFit.contain,
      );
    }

    // Assign content to leading or center
    if (isLeadinTitle || isLeadingLogo) {
      leadingWidget ??= Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Align(alignment: Alignment.centerLeft, child: contentWidget),
      );
      titleWidget = null;
    } else {
      titleWidget = contentWidget;
    }

    return AppBar(
      toolbarHeight: 72,
      backgroundColor: backgroundColor ?? AppColors.lightGray,
      elevation: elevation,
      leading: leadingWidget,
      leadingWidth: (isLeadinTitle || isLeadingLogo) ? 200 : null,
      title: titleWidget,
      centerTitle: true,
      actions: actions?.map((action) {
        return Container(
          height: 40,
          width: 40,
          margin: EdgeInsets.only(right: 8),
       
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.background, // background color
          ),
          child: Center(
       
              child: Opacity(
                opacity: 0.7,
                 child: action), // the actual action widget (icon, etc.)
           
          ),
        );
      }).toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}
