import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class AuthUsecaseLogin {
  final AuthRepository authRepository;

  AuthUsecaseLogin({required this.authRepository});

  Future<UserEntity> call(String email, String password) async {
    try {
      return await authRepository.login(email: email, password: password);
    } catch (error) {
      throw Exception('Login failed: $error');
    }
  }
}
