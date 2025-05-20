import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../utils/api_constants.dart';
import '../utils/logger.dart' as Logger;

class DioClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  DioClient(this._dio, this._storage) {
    _dio.options
      ..baseUrl = AppApi.baseUrl
      ..connectTimeout = Duration(seconds: 30)
      ..receiveTimeout = Duration(seconds: 30)
      ..contentType = 'application/json';

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
            // options.headers['x-api-key'] = ApiConstants.apiKey;
          }
          Logger.log('Request: ${options.method} ${options.uri}');
          Logger.log('Request Body: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          Logger.log('Response: ${response.statusCode} ${response.data}');

          final resData = response.data;
          if (resData is Map<String, dynamic>) {
            if (resData['code'] == 200 && resData['data'] != null) {
              response.data = resData['data'];
              return handler.next(response);
            } else {
              // Xử lý lỗi khi code không phải 200
              String errorMessage =
                  resData['message'] ?? 'Lỗi: mã ${resData['code']}';
              return handler.reject(
                DioException(
                  requestOptions: response.requestOptions,
                  error: errorMessage,
                  response: response,
                ),
              );
            }
          } else {
            return handler.next(response);
          }
        },
        onError: (DioException e, handler) async {
          Logger.error('Error: ${e.message}');
          Logger.error('Response Data: ${e.response?.data}');

          // Trích xuất thông báo lỗi từ dữ liệu phản hồi
          String errorMessage = e.message ?? 'Đã xảy ra lỗi';
          if (e.response?.data is Map<String, dynamic>) {
            errorMessage = e.response!.data['message'] ?? errorMessage;
          }

          if (e.response?.statusCode == 401) {
            try {
              final newToken = await _refreshToken();
              e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
              return handler.resolve(await _dio.fetch(e.requestOptions));
            } catch (_) {
              await _storage.deleteAll();
              return handler.next(
                DioException(
                  requestOptions: e.requestOptions,
                  error: errorMessage,
                  response: e.response,
                ),
              );
            }
          }
          return handler.next(
            DioException(
              requestOptions: e.requestOptions,
              error: errorMessage,
              response: e.response,
            ),
          );
        },
      ),
    );
  }

  Future<String> _refreshToken() async {
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken == null) throw Exception('Không có refresh token');
    final response = await _dio.post(
      '/auth/refresh',
      data: {'refresh_token': refreshToken},
    );
    final newToken = response.data['token'];
    final newRefreshToken = response.data['refresh_token'];
    await _storage.write(key: 'auth_token', value: newToken);
    await _storage.write(key: 'refresh_token', value: newRefreshToken);
    return newToken;
  }

  Dio get dio => _dio;
}
