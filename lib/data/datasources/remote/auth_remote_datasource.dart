import 'package:logger/web.dart';

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

  Future<AuthModel> register(Map<String, dynamic> userData) async {
    final response = await apiService.post('auth/register', userData, null);
    return AuthModel.fromJson(response);
  }

}
