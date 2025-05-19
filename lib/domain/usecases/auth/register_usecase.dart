import 'package:workbond/domain/repositories/auth_repository_impl.dart';
import '../../entities/auth_entity.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<AuthEntity> call(String name, String email, String password) {
    return repository.register(name, email, password);
  }
}
