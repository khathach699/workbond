import 'package:workbond/core/utils/app_strings.dart';

class AuthValidator {
  static String? validateEmail(String email) {
    if (email.isEmpty) return AppStrings.emailEmpty;
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  static String? validateFullName(String fullName) {
    if (fullName.isEmpty) return AppStrings.fullNameEmpty;
    if (fullName.length < 2) return 'Họ tên phải có ít nhất 2 ký tự';
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) return 'Vui lòng nhập mật khẩu';
    if (password.length < 8) return 'Mật khẩu phải có ít nhất 8 ký tự';
    if (!RegExp(
      r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*]).{8,}$',
    ).hasMatch(password)) {
      return 'Mật khẩu phải chứa ít nhất 1 chữ in hoa, 1 số và 1 ký tự đặc biệt';
    }
    return null;
  }
}
