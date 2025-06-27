import '../repositories/auth_repository.dart';

class AuthUsecaseLogout {
  final AuthRepository authRepository;

  AuthUsecaseLogout({required this.authRepository});

  Future<void> call() async {
    try {
      return await authRepository.logout();
    } catch (error) {
      throw Exception('Logout failed: $error');
    }
  }
}
