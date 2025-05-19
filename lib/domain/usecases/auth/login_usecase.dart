import 'package:workbond/domain/repositories/auth_repository_impl.dart';
import '../../entities/auth_entity.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthEntity> call(String email, String password) {
    return repository.login(email, password);
  }
}
