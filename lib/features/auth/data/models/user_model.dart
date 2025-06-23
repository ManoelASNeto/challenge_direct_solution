import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String email;
  final String password;

  const UserModel({
    required this.email,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  UserEntity toEntity() => UserEntity(
        email: email,
        password: password,
      );

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
