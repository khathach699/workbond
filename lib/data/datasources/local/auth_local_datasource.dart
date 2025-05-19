import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage storage;
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  AuthLocalDataSource(this.storage);

  Future<void> cacheToken(String token) async {
    await storage.write(key: _tokenKey, value: token);
  }

  Future<void> cacheRefreshToken(String refreshToken) async {
    await storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getToken() async {
    return await storage.read(key: _tokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: _refreshTokenKey);
  }

  Future<void> clearTokens() async {
    await storage.delete(key: _tokenKey);
    await storage.delete(key: _refreshTokenKey);
  }
}
