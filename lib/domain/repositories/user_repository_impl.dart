import 'package:workbond/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity> register(String fullName, String email, String password);
}
