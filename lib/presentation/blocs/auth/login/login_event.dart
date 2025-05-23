import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted(
    this.email,
    this.password,
  );

  @override
  List<Object?> get props => [email, password];
}

class RegisterSubmitted extends LoginEvent {
  final String name;
  final String email;
  final String password;

  RegisterSubmitted(this.name, this.email, this.password);

  @override
  List<Object?> get props => [name, email, password];
}

