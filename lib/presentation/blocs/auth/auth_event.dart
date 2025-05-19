import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  LoginSubmitted(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class RegisterSubmitted extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterSubmitted(this.name, this.email, this.password);

  @override
  List<Object?> get props => [name, email, password];
}

class GetProfileRequested extends AuthEvent {}

class UpdateProfileSubmitted extends AuthEvent {
  final String name;
  final String email;

  UpdateProfileSubmitted(this.name, this.email);

  @override
  List<Object?> get props => [name, email];
}

class DeleteAccountRequested extends AuthEvent {}
