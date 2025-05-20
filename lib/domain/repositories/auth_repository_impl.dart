import 'package:workbond/domain/entities/auth_entity.dart';
import 'package:workbond/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<AuthEntity> login(String email, String password);
  Future<UserEntity> register(String fullName, String email, String password);
}
