import 'package:flutter/material.dart';
import 'package:workbond/core/utils/app_colors.dart';
import 'package:workbond/core/utils/responsive.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    this.icon,
    this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed, // Vô hiệu hóa khi đang tải
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, responsive.scaleHeight(48)),
        padding: EdgeInsets.symmetric(
          vertical: responsive.scaleHeight(12),
          horizontal: responsive.scaleWidth(16),
        ),
        textStyle: TextStyle(
          fontSize: responsive.fontSize(16),
          color: textColor ?? Colors.white,
        ),
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
        disabledBackgroundColor: AppColors.primaryColor.withOpacity(0.5),
      ),
      child: isLoading
          ? SizedBox(
              width: responsive.scaleWidth(20),
              height: responsive.scaleWidth(20),
              child: CircularProgressIndicator(
                color: textColor ?? Colors.white,
                strokeWidth: 2,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: responsive.fontSize(18),
                    color: textColor ?? Colors.white,
                  ),
                  SizedBox(width: responsive.scaleWidth(8)),
                ],
                Text(
                  text,
                  style: TextStyle(fontSize: responsive.fontSize(16)),
                ),
              ],
            ),
    );
  }
}
