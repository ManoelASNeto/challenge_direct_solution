import 'package:bloc_test/bloc_test.dart';
import 'package:challenge_direct_solution/features/auth/domain/entities/user_entity.dart';
import 'package:challenge_direct_solution/features/auth/domain/usecases/auth_usecase_get_current_user.dart';
import 'package:challenge_direct_solution/features/auth/domain/usecases/auth_usecase_login.dart';
import 'package:challenge_direct_solution/features/auth/domain/usecases/auth_usecase_login_with_facebook.dart';
import 'package:challenge_direct_solution/features/auth/domain/usecases/auth_usecase_login_with_google.dart';
import 'package:challenge_direct_solution/features/auth/domain/usecases/auth_usecase_logout.dart';
import 'package:challenge_direct_solution/features/auth/domain/usecases/auth_usecase_register.dart';
import 'package:challenge_direct_solution/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCurrentUserUsecase extends Mock implements AuthUsecaseGetCurrentUser {}

class MockLoginUsecase extends Mock implements AuthUsecaseLogin {}

class MockRegisterUsecase extends Mock implements AuthUsecaseRegister {}

class MockLoginWithFacebookUsecase extends Mock implements AuthUsecaseLoginWithFacebook {}

class MockLoginWithGoogleUsecase extends Mock implements AuthUsecaseLoginWithGoogle {}

class MockLogoutUsecase extends Mock implements AuthUsecaseLogout {}

void main() {
  late AuthCubit authCubit;
  late MockGetCurrentUserUsecase mockGetCurrentUser;
  late MockLoginUsecase mockLogin;
  late MockRegisterUsecase mockRegister;
  late MockLoginWithFacebookUsecase mockLoginWithFacebook;
  late MockLoginWithGoogleUsecase mockLoginWithGoogle;
  late MockLogoutUsecase mockLogout;

  setUp(() {
    mockGetCurrentUser = MockGetCurrentUserUsecase();
    mockLogin = MockLoginUsecase();
    mockRegister = MockRegisterUsecase();
    mockLoginWithFacebook = MockLoginWithFacebookUsecase();
    mockLoginWithGoogle = MockLoginWithGoogleUsecase();
    mockLogout = MockLogoutUsecase();

    authCubit = AuthCubit(
      mockGetCurrentUser,
      mockLogin,
      mockRegister,
      mockLoginWithFacebook,
      mockLoginWithGoogle,
      mockLogout,
    );
  });

  final tUser = UserEntity(uid: '123', email: 'test@test.com', name: 'Test User', photoUrl: null);

  group('checkAuthentication', () {
    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthAuthenticated] quando getCurrentUser retorna usuário',
      build: () {
        when(() => mockGetCurrentUser()).thenAnswer((_) async => tUser);
        return authCubit;
      },
      act: (cubit) => cubit.checkAuthentication(),
      expect: () => [AuthLoading(), AuthAuthenticated(user: tUser)],
      verify: (_) => verify(() => mockGetCurrentUser()).called(1),
    );

    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthUnauthenticated] quando getCurrentUser retorna null',
      build: () {
        when(() => mockGetCurrentUser()).thenAnswer((_) async => null);
        return authCubit;
      },
      act: (cubit) => cubit.checkAuthentication(),
      expect: () => [AuthLoading(), AuthUnauthenticated()],
    );

    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthUnauthenticated] quando getCurrentUser lança exceção',
      build: () {
        when(() => mockGetCurrentUser()).thenThrow(Exception('Erro'));
        return authCubit;
      },
      act: (cubit) => cubit.checkAuthentication(),
      expect: () => [AuthLoading(), AuthUnauthenticated()],
    );
  });

  group('login', () {
    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthAuthenticated] quando login é bem-sucedido',
      build: () {
        when(() => mockLogin.call('email@test.com', 'password')).thenAnswer((_) async => tUser);
        return authCubit;
      },
      act: (cubit) => cubit.login('email@test.com', 'password'),
      expect: () => [AuthLoading(), AuthAuthenticated(user: tUser)],
      verify: (_) => verify(() => mockLogin.call('email@test.com', 'password')).called(1),
    );

    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthError] quando login falha',
      build: () {
        when(() => mockLogin.call('email@test.com', 'password')).thenThrow(Exception('Login failed'));
        return authCubit;
      },
      act: (cubit) => cubit.login('email@test.com', 'password'),
      expect: () => [AuthLoading(), isA<AuthError>()],
    );
  });

  group('register', () {
    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthAuthenticated] quando registro é bem-sucedido',
      build: () {
        when(() => mockRegister.call('new@test.com', 'password')).thenAnswer((_) async => tUser);
        return authCubit;
      },
      act: (cubit) => cubit.register('new@test.com', 'password'),
      expect: () => [AuthLoading(), AuthAuthenticated(user: tUser)],
    );

    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthError] quando registro falha',
      build: () {
        when(() => mockRegister.call('new@test.com', 'password')).thenThrow(Exception('Registration failed'));
        return authCubit;
      },
      act: (cubit) => cubit.register('new@test.com', 'password'),
      expect: () => [AuthLoading(), isA<AuthError>()],
    );
  });

  group('loginWithFacebook', () {
    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthAuthenticated] quando login com Facebook é bem-sucedido',
      build: () {
        when(() => mockLoginWithFacebook.call()).thenAnswer((_) async => tUser);
        return authCubit;
      },
      act: (cubit) => cubit.loginWithFacebook(),
      expect: () => [AuthLoading(), AuthAuthenticated(user: tUser)],
    );

    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthError] quando login com Facebook falha',
      build: () {
        when(() => mockLoginWithFacebook.call()).thenThrow(Exception('Facebook login failed'));
        return authCubit;
      },
      act: (cubit) => cubit.loginWithFacebook(),
      expect: () => [AuthLoading(), isA<AuthError>()],
    );
  });

  group('loginWithGoogle', () {
    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthAuthenticated] quando login com Google é bem-sucedido',
      build: () {
        when(() => mockLoginWithGoogle.call()).thenAnswer((_) async => tUser);
        return authCubit;
      },
      act: (cubit) => cubit.loginWithGoogle(),
      expect: () => [AuthLoading(), AuthAuthenticated(user: tUser)],
    );

    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthError] quando login com Google falha',
      build: () {
        when(() => mockLoginWithGoogle.call()).thenThrow(Exception('Google login failed'));
        return authCubit;
      },
      act: (cubit) => cubit.loginWithGoogle(),
      expect: () => [AuthLoading(), isA<AuthError>()],
    );
  });

  group('logout', () {
    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthUnauthenticated] quando logout é bem-sucedido',
      build: () {
        when(() => mockLogout.call()).thenAnswer((_) async {});
        return authCubit;
      },
      act: (cubit) => cubit.logout(),
      expect: () => [AuthLoading(), AuthUnauthenticated()],
      verify: (_) => verify(() => mockLogout.call()).called(1),
    );

    blocTest<AuthCubit, AuthState>(
      'emite [AuthLoading, AuthError] quando logout falha',
      build: () {
        when(() => mockLogout.call()).thenThrow(Exception('Logout failed'));
        return authCubit;
      },
      act: (cubit) => cubit.logout(),
      expect: () => [AuthLoading(), isA<AuthError>()],
    );
  });
}
