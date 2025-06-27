import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class AuthUsecaseLoginWithGoogle {
  final AuthRepository authRepository;

  AuthUsecaseLoginWithGoogle({required this.authRepository});

  Future<UserEntity> call() async {
    return await authRepository.loginWithGoogle();
  }
}
