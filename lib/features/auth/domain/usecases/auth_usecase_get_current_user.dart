import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class AuthUsecaseGetCurrentUser {
  final AuthRepository authRepository;

  AuthUsecaseGetCurrentUser({required this.authRepository});

  Future<UserEntity> call() async {
    try {
      return await authRepository.getCurrentUser();
    } catch (error) {
      throw Exception('Failed to get current user: $error');
    }
  }
}
