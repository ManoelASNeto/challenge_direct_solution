import 'package:challenge_direct_solution/features/auth/domain/entities/user_entity.dart';
import 'package:challenge_direct_solution/features/auth/domain/repositories/auth_repository.dart';

class AuthUsecaseLogin {
  final AuthRepository authRepository;

  AuthUsecaseLogin({required this.authRepository});

  Future<UserEntity> login({required String email, required String password}) async {
    try {
      return await authRepository.login(email: email, password: password);
    } catch (error) {
      throw Exception('Login failed: $error');
    }
  }
}
