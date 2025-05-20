import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String token;
  final bool authenticated;

  const AuthEntity({required this.token, required this.authenticated});

  @override
  List<Object?> get props => [token, authenticated];
}
