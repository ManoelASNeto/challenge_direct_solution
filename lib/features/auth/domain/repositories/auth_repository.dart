import 'package:challenge_direct_solution/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> getCurrentUser();
  Future<UserEntity> login({required String email, required String password});
  Future<UserEntity> register({required String email, required String password});
  Future<void> logout();
}
