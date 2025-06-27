import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String email;
  final String uid;
  final String? name;
  final String? photoUrl;

  const UserModel({
    required this.email,
    required this.uid,
    this.name,
    this.photoUrl,
  });

  factory UserModel.fromFirebaseUser(User? user) {
    return UserModel(
      email: user?.email ?? '',
      uid: user?.uid ?? '',
      name: user?.displayName,
      photoUrl: user?.photoURL,
    );
  }

  UserEntity toEntity() => UserEntity(
        email: email,
        uid: uid,
        name: name,
        photoUrl: photoUrl,
      );

  @override
  List<Object?> get props => [
        email,
        uid,
        name,
        photoUrl,
      ];
}
