import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:partner/core/constants/app_colors.dart';

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
  final TextStyle? titleStyle;
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
    this.titleStyle,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    // Determine leading widget
    Widget? leadingWidget;
    if (showBack) {
      leadingWidget = IconButton(
        icon: Icon(Icons.arrow_back, color: iconColor ?? Colors.black),
        onPressed:
            onBack ??
            () {
              if (GoRouter.of(context).canPop()) {
                context.pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("No previous page to go back to"),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
      );
    } else if (isLeadingLogo) {
      // Show logo in leading if you want left-aligned logo instead of center
      leadingWidget = Image.asset('assets/logo.png', height: 40,width: 119,); // center logo will handle it
    }else if(isLeadinTitle && title != null && title!.isNotEmpty){
      leadingWidget =Text(
        title!,
        style:
            titleStyle ??
            const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
      ); 
    } else {
      leadingWidget = null; 
    }

    Widget? centerWidget;

    if( showLogo && !isLeadingLogo){ 
      centerWidget = Image.asset('assets/logo.png', height: 40);
    } else if (title != null && title!.isNotEmpty && !isLeadinTitle) {
      centerWidget = Text(
        title!,
        style:
            titleStyle ??
            const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
      );
    }else{
      centerWidget = null; // nothing to show
    }

    return AppBar(
      toolbarHeight: 72,
      backgroundColor: backgroundColor ??  AppColors.lightGray,
      elevation: elevation,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: leadingWidget,
      ),
      title: centerWidget,
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}