import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final String uid;
  final String? name;
  final String? photoUrl;

  const UserEntity({
    required this.email,
    required this.uid,
    this.name,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        name,
        photoUrl,
      ];
}
