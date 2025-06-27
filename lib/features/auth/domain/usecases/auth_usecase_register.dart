import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class AuthUsecaseRegister {
  final AuthRepository authRepository;

  AuthUsecaseRegister({required this.authRepository});

  Future<UserEntity> call(String email, String password) {
    return authRepository.register(email: email, password: password);
  }
}
