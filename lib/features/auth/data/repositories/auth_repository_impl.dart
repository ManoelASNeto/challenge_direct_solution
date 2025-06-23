import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({required this.authRemoteDatasource});

  @override
  Future<UserEntity> getCurrentUser() {
    return authRemoteDatasource.getCurrentUser().then((userModel) {
      return UserEntity(email: userModel.email, password: userModel.password);
    }).catchError((error) {
      throw Exception('Failed to get current user: $error');
    });
  }

  @override
  Future<UserEntity> login({required String email, required String password}) {
    return authRemoteDatasource.login(email: email, password: password).then((userModel) {
      return UserEntity(email: email, password: password);
    }).catchError((error) {
      throw Exception('Login failed: $error');
    });
  }

  @override
  Future<UserEntity> register({required String email, required String password}) {
    return authRemoteDatasource.register(email: email, password: password).then((userModel) {
      return UserEntity(email: email, password: password);
    }).catchError((error) {
      throw Exception('Registration failed: $error');
    });
  }

  @override
  Future<void> logout() {
    return authRemoteDatasource.logout().catchError((error) {
      throw Exception('Logout failed: $error');
    });
  }
}
