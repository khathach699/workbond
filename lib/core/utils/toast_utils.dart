import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:workbond/core/utils/app_colors.dart';

class ToastUtils {
  static void showCustomToast(
    BuildContext context, {
    required String title,
    required String message,
    required ToastificationType type,
    Duration duration = const Duration(seconds: 3),
    Alignment alignment = Alignment.topRight,
  }) {
    // Kiểm tra title và message để tránh chuỗi rỗng
    final safeTitle = title.isEmpty ? 'Thông báo' : title;
    final safeMessage =
        message.isEmpty ? 'Không có thông tin chi tiết' : message;

    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.fillColored,
      title: Text(
        safeTitle,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white, // Đảm bảo tương phản
        ),
      ),
      description: Text(
        safeMessage,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white, // Đảm bảo tương phản
        ),
      ),
      alignment: alignment,
      autoCloseDuration: duration,
      primaryColor: _getPrimaryColor(type),
      backgroundColor: _getBackgroundColor(type),
      foregroundColor: Colors.white,
      icon: _getIcon(type),
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 16), // Tăng padding
      margin: const EdgeInsets.fromLTRB(24, 24, 24, 8), // Tăng margin
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
      showProgressBar: true,
      progressBarTheme: ProgressIndicatorThemeData(
        color: Colors.white.withOpacity(0.8),
      ),
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
    );
  }

  static void showSuccessToast(
    BuildContext context, {
    required String message,
    String title = 'Thành công',
    Duration duration = const Duration(seconds: 3),
    Alignment alignment = Alignment.topRight,
  }) {
    showCustomToast(
      context,
      title: title,
      message: message,
      type: ToastificationType.success,
      duration: duration,
      alignment: alignment,
    );
  }

  static void showErrorToast(
    BuildContext context, {
    required String message,
    String title = 'Lỗi',
    Duration duration = const Duration(seconds: 3),
    Alignment alignment = Alignment.topRight,
  }) {
    showCustomToast(
      context,
      title: title,
      message: message,
      type: ToastificationType.error,
      duration: duration,
      alignment: alignment,
    );
  }

  static Color _getPrimaryColor(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return AppColors.successColor;
      case ToastificationType.error:
        return AppColors.errorColor;
      case ToastificationType.warning:
        return AppColors.warningColor;
      case ToastificationType.info:
      default:
        return AppColors.primaryColor;
    }
  }

  static Color _getBackgroundColor(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return AppColors.successColor.withOpacity(0.9);
      case ToastificationType.error:
        return AppColors.errorColor.withOpacity(0.9);
      case ToastificationType.warning:
        return AppColors.warningColor.withOpacity(0.9);
      case ToastificationType.info:
      default:
        return AppColors.primaryColor.withOpacity(0.9);
    }
  }

  static Widget _getIcon(ToastificationType type) {
    switch (type) {
      case ToastificationType.success:
        return const Icon(Icons.check_circle, color: Colors.white);
      case ToastificationType.error:
        return const Icon(Icons.error, color: Colors.white);
      case ToastificationType.warning:
        return const Icon(Icons.warning, color: Colors.white);
      case ToastificationType.info:
      default:
        return const Icon(Icons.info, color: Colors.white);
    }
  }
}
