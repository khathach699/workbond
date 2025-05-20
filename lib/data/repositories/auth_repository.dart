import 'package:dio/dio.dart';
import 'package:workbond/data/datasources/local/auth_local_datasource.dart';
import 'package:workbond/data/datasources/remote/auth_remote_datasource.dart';
import 'package:workbond/domain/entities/auth_entity.dart';
import 'package:workbond/domain/entities/user_entity.dart';
import 'package:workbond/domain/repositories/auth_repository_impl.dart';
import '../../../core/error/exceptions.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<AuthEntity> login(String email, String password) async {
    try {
      final authModel = await remoteDataSource.login({
        'email': email,
        'password': password,
      });
      await localDataSource.cacheToken(authModel.token);
      // await localDataSource.cacheRefreshToken(authModel.refreshToken);
      return authModel;
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Login failed');
    }
  }

  @override
  Future<AuthEntity> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final authModel = await remoteDataSource.register({
        'name': name,
        'email': email,
        'password': password,
      });
      await localDataSource.cacheToken(authModel.token);
      // await localDataSource.cacheRefreshToken(authModel.refreshToken);
      return authModel;
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Register failed');
    }
  }



}
