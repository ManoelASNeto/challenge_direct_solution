import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final userModel = await authRemoteDatasource.getCurrentUser();
      return userModel.toEntity();
    } catch (error) {
      throw Exception('Failed to get current user: $error');
    }
  }

  @override
  Future<UserEntity> login({required String email, required String password}) async {
    try {
      final userModel = await authRemoteDatasource.login(email: email, password: password);
      return userModel.toEntity();
    } catch (error) {
      throw Exception('Login failed: $error');
    }
  }

  @override
  Future<UserEntity> register({required String email, required String password}) async {
    try {
      final userModel = await authRemoteDatasource.register(email: email, password: password);
      return userModel.toEntity();
    } catch (error) {
      throw Exception('Registration failed: $error');
    }
  }

  @override
  Future<UserEntity> loginWithFacebook() async {
    try {
      final userModel = await authRemoteDatasource.loginWithFacebook();
      return userModel.toEntity();
    } catch (error) {
      throw Exception('Facebook login failed: $error');
    }
  }

  @override
  Future<void> logout() {
    return authRemoteDatasource.logout().catchError((error) {
      throw Exception('Logout failed: $error');
    });
  }
}
