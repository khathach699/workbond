import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends LoginState {}

class AuthLoading extends LoginState {}

class AuthSuccess extends LoginState {}

class AuthError extends LoginState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
