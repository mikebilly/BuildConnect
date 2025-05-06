export 'package:buildconnect/shared/widgets/form_widgets.dart';
export 'package:buildconnect/shared/widgets/profile_view_widgets.dart';

import 'package:buildconnect/core/theme/theme.dart';
import 'package:flutter/material.dart';

Widget buildTabBar({
  required TabController controller,
  required List<String> tabTitles,
  Color indicatorColor = Colors.white,
  Color labelColor = Colors.white,
  Color unselectedLabelColor = const Color.fromARGB(128, 255, 255, 255),
}) {
  return TabBar(
    controller: controller,
    indicatorColor: indicatorColor,
    labelColor: labelColor,
    unselectedLabelColor: unselectedLabelColor,
    tabs: tabTitles.map((title) => Tab(text: title)).toList(),
  );
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isLoading;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : Colors.transparent,
          foregroundColor: isPrimary ? Colors.white : AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: isPrimary ? 2 : 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(color: AppColors.primary),
          ),
          disabledBackgroundColor: isPrimary
              ? AppColors.primary.withAlpha(128)
              : Colors.transparent,
          disabledForegroundColor: isPrimary
              ? Colors.white.withAlpha(180)
              : AppColors.primary.withAlpha(128),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isPrimary ? Colors.white : AppColors.primary,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18),
                    const SizedBox(width: 8),
                  ],
                  Text(text),
                ],
              ),
      ),
    );
  }
}
