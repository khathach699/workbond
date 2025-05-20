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

class GetProfileRequested extends LoginEvent {}

class UpdateProfileSubmitted extends LoginEvent {
  final String name;
  final String email;

  UpdateProfileSubmitted(this.name, this.email);

  @override
  List<Object?> get props => [name, email];
}

class DeleteAccountRequested extends LoginEvent {}
