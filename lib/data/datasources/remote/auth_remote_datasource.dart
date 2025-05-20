import 'package:dio/dio.dart';
import 'package:logger/web.dart';
import 'package:workbond/core/error/exceptions.dart';
import 'package:workbond/data/models/user_model.dart';

import '../../../core/network/api_service.dart';
import '../../models/auth_model.dart';

class AuthRemoteDataSource {
  final ApiService apiService;
  final log = Logger();
  AuthRemoteDataSource(this.apiService);

  Future<AuthModel> login(Map<String, dynamic> credentials) async {
    log.i(credentials);
    final response = await apiService.post('auth', credentials, null);
    log.i(response);
    return AuthModel.fromJson(response);
  }

  Future<UserModel> register(Map<String, dynamic> userData) async {
    try {
      final response = await apiService.post('user', userData, null);
      return UserModel.fromJson(response);
    } catch (e) {
      log.e('Đăng ký thất bại: $e');
      if (e is DioException && e.error is String) {
        throw ServerException(e.error as String); // Lấy message từ backend
      } else if (e is DioException &&
          e.response?.data is Map<String, dynamic>) {
        // Lấy message từ response.data nếu có
        final data = e.response!.data;
        throw ServerException(
            data['message']?.toString() ?? 'Đã xảy ra lỗi khi đăng ký');
      } else {
        throw ServerException('Đã xảy ra lỗi khi đăng ký');
      }
    }
  }
}
