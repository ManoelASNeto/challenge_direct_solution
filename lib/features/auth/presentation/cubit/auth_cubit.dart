import 'package:bloc/bloc.dart';
import 'package:challenge_direct_solution/features/auth/domain/usecases/auth_usecase_login_with_google.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/auth_usecase_get_current_user.dart';
import '../../domain/usecases/auth_usecase_login.dart';
import '../../domain/usecases/auth_usecase_login_with_facebook.dart';
import '../../domain/usecases/auth_usecase_logout.dart';
import '../../domain/usecases/auth_usecase_register.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecaseGetCurrentUser getCurrentUser;
  final AuthUsecaseLogin usecaseLogin;
  final AuthUsecaseRegister usecaseRegister;
  final AuthUsecaseLoginWithFacebook usecaseLoginWithFacebook;
  final AuthUsecaseLoginWithGoogle usecaseLoginWithGoogle;
  final AuthUsecaseLogout usecaseLogout;
  AuthCubit(
    this.getCurrentUser,
    this.usecaseLogin,
    this.usecaseRegister,
    this.usecaseLoginWithFacebook,
    this.usecaseLoginWithGoogle,
    this.usecaseLogout,
  ) : super(AuthInitial());

  Future<void> checkAuthentication() async {
    emit(AuthLoading());
    try {
      final user = await getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (error) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await usecaseLogin.call(email, password);
      emit(AuthAuthenticated(user: user));
    } catch (error) {
      emit(AuthError(message: error.toString()));
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await usecaseRegister.call(email, password);
      emit(AuthAuthenticated(user: user));
    } catch (error) {
      emit(AuthError(message: error.toString()));
    }
  }

  Future<void> loginWithFacebook() async {
    emit(AuthLoading());
    try {
      final user = await usecaseLoginWithFacebook.call();
      emit(AuthAuthenticated(user: user));
    } catch (error) {
      emit(AuthError(message: error.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(AuthLoading());
    try {
      final user = await usecaseLoginWithGoogle.call();
      emit(AuthAuthenticated(user: user));
    } catch (error) {
      emit(AuthError(message: error.toString()));
      print(error.toString());
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await usecaseLogout.call();
      emit(AuthUnauthenticated());
    } catch (error) {
      emit(AuthError(message: error.toString()));
    }
  }
}
