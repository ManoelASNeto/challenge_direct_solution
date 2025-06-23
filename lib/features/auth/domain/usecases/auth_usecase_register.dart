import 'package:challenge_direct_solution/features/auth/domain/entities/user_entity.dart';
import 'package:challenge_direct_solution/features/auth/domain/repositories/auth_repository.dart';

class AuthUsecaseRegister {
  final AuthRepository authRepository;

  AuthUsecaseRegister({required this.authRepository});

  Future<UserEntity> register({required String email, required String password}) {
    return authRepository.register(email: email, password: password);
  }
}
