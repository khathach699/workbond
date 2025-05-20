import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String fullName;
  final String password;

  RegisterSubmitted(this.fullName, this.email, this.password);

  @override
  List<Object?> get props => [
        fullName,
        email,
        password,
      ];
}
