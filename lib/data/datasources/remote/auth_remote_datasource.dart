import '../../../core/network/api_service.dart';
import '../../models/auth_model.dart';
import '../../models/user_model.dart';

class AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSource(this.apiService);

  Future<AuthModel> login(Map<String, dynamic> credentials) async {
    final response = await apiService.post('auth/login', credentials, null);
    return AuthModel.fromJson(response);
  }

  Future<AuthModel> register(Map<String, dynamic> userData) async {
    final response = await apiService.post('auth/register', userData, null);
    return AuthModel.fromJson(response);
  }

  Future<UserModel> getProfile() async {
    final response = await apiService.get('auth/profile', null);
    return UserModel.fromJson(response);
  }

  Future<UserModel> updateProfile(Map<String, dynamic> userData) async {
    final response = await apiService.put('auth/profile', userData, null);
    return UserModel.fromJson(response);
  }

  Future<void> deleteAccount() async {
    await apiService.delete('auth/account', null);
  }
}
