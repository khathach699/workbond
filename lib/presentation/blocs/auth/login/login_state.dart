import 'package:equatable/equatable.dart';
import '../../../../domain/entities/user_entity.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends LoginState {}

class AuthLoading extends LoginState {}

class AuthSuccess extends LoginState {}

class ProfileLoaded extends LoginState {
  final UserEntity user;

  ProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends LoginState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
