import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/api_constants.dart';
import '../utils/logger.dart' as Logger;

class DioClient {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  DioClient(this._dio, this._storage) {
    _dio.options
      ..baseUrl = ApiConstants.baseUrl
      ..connectTimeout = Duration(seconds: 30)
      ..receiveTimeout = Duration(seconds: 30);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: 'auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
            // options.headers['x-api-key'] = ApiConstants.apiKey;
          }
          Logger.log('Request: ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          Logger.log('Response: ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          Logger.error('Error: ${e.message}');
          if (e.response?.statusCode == 401) {
            try {
              final newToken = await _refreshToken();
              e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
              return handler.resolve(await _dio.fetch(e.requestOptions));
            } catch (_) {
              await _storage.deleteAll();
              return handler.next(e);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<String> _refreshToken() async {
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken == null) throw Exception('No refresh token');
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
