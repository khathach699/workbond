import 'package:workbond/domain/repositories/auth_repository_impl.dart';

import '../../entities/user_entity.dart';

class UpdateProfileUseCase {
  final AuthRepository repository;

  UpdateProfileUseCase(this.repository);

}
