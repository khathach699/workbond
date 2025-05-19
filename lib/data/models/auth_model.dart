import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/auth_entity.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel extends AuthEntity {
  AuthModel({required super.token, required super.refreshToken});

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}
