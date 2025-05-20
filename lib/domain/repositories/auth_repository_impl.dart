import 'package:workbond/domain/entities/auth_entity.dart';
import 'package:workbond/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<AuthEntity> login(String email, String password);
  Future<AuthEntity> register(String name, String email, String password);
}
