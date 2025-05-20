import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/auth_entity.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel extends AuthEntity {
  const AuthModel({required super.token, required super.authenticated});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final data =
        json['data'] as Map<String, dynamic>? ?? json; // Handle nested data
    return _$AuthModelFromJson(data);
  }
  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}
