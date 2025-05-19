import 'package:workbond/domain/repositories/auth_repository_impl.dart';
import '../../entities/user_entity.dart';

class GetProfileUseCase {
  final AuthRepository repository;

  GetProfileUseCase(this.repository);

  Future<UserEntity> call() {
    return repository.getProfile();
  }
}
