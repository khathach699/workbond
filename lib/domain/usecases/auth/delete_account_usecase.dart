import 'package:workbond/domain/repositories/auth_repository_impl.dart';

class DeleteAccountUseCase {
  final AuthRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<void> call() {
    return repository.deleteAccount();
  }
}
