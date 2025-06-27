import 'package:challenge_direct_solution/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:challenge_direct_solution/features/auth/data/models/user_model.dart';
import 'package:challenge_direct_solution/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:challenge_direct_solution/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

void main() {
  late AuthRepositoryImpl authRepositoryImpl;
  late MockAuthRemoteDatasource mockAuthRemoteDatasource;

  setUp(() {
    mockAuthRemoteDatasource = MockAuthRemoteDatasource();
    authRepositoryImpl = AuthRepositoryImpl(authRemoteDatasource: mockAuthRemoteDatasource);
  });

  group('AuthRepositoryImpl', () {
    test('should return UserEntity when getCurrentUser is successful', () async {
      final tUserModel = UserModel(
        uid: '123',
        email: 'test@example.com',
        name: 'Test User',
        photoUrl: 'http://photo.com/test.jpg',
      );
      when(() => mockAuthRemoteDatasource.getCurrentUser()).thenAnswer((_) async => tUserModel);

      final result = await authRepositoryImpl.getCurrentUser();

      expect(result, isA<UserEntity>());
      expect(result?.uid, tUserModel.uid);
      expect(result?.email, tUserModel.email);
      expect(result?.name, tUserModel.name);
      expect(result?.photoUrl, tUserModel.photoUrl);
      verify(() => mockAuthRemoteDatasource.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });

    test('should throw Exception when getCurrentUser fails', () async {
      when(() => mockAuthRemoteDatasource.getCurrentUser()).thenThrow(Exception('No user found'));

      expect(
        () => authRepositoryImpl.getCurrentUser(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Failed to get current user'))),
      );
      verify(() => mockAuthRemoteDatasource.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });

    test('should return UserEntity when login is successful', () async {
      final tEmail = 'test@example.com';
      final tPassword = 'password123';
      final tUserModel = UserModel(uid: '123', email: tEmail, name: 'Test User');
      when(() => mockAuthRemoteDatasource.login(email: tEmail, password: tPassword))
          .thenAnswer((_) async => tUserModel);

      final result = await authRepositoryImpl.login(email: tEmail, password: tPassword);

      expect(result, isA<UserEntity>());
      expect(result.uid, tUserModel.uid);
      expect(result.email, tUserModel.email);
      verify(() => mockAuthRemoteDatasource.login(email: tEmail, password: tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });

    test('should throw Exception when login fails', () async {
      final tEmail = 'test@example.com';
      final tPassword = 'password123';
      when(() => mockAuthRemoteDatasource.login(email: tEmail, password: tPassword))
          .thenThrow(Exception('Invalid credentials'));

      expect(
        () => authRepositoryImpl.login(email: tEmail, password: tPassword),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Login failed'))),
      );
      verify(() => mockAuthRemoteDatasource.login(email: tEmail, password: tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });

    test('should return UserEntity when register is successful', () async {
      final tEmail = 'newuser@example.com';
      final tPassword = 'newpassword';
      final tUserModel = UserModel(uid: '456', email: tEmail, name: 'New User');
      when(() => mockAuthRemoteDatasource.register(email: tEmail, password: tPassword))
          .thenAnswer((_) async => tUserModel);

      final result = await authRepositoryImpl.register(email: tEmail, password: tPassword);

      expect(result, isA<UserEntity>());
      expect(result.uid, tUserModel.uid);
      expect(result.email, tUserModel.email);
      verify(() => mockAuthRemoteDatasource.register(email: tEmail, password: tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });

    test('should throw Exception when register fails', () async {
      final tEmail = 'newuser@example.com';
      final tPassword = 'newpassword';
      when(() => mockAuthRemoteDatasource.register(email: tEmail, password: tPassword))
          .thenThrow(Exception('Email already in use'));

      expect(
        () => authRepositoryImpl.register(email: tEmail, password: tPassword),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Registration failed'))),
      );
      verify(() => mockAuthRemoteDatasource.register(email: tEmail, password: tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });

    test('should return UserEntity when loginWithFacebook is successful', () async {
      final tUserModel = UserModel(uid: 'fb123', email: 'fb@example.com', name: 'Facebook User');
      when(() => mockAuthRemoteDatasource.loginWithFacebook()).thenAnswer((_) async => tUserModel);

      final result = await authRepositoryImpl.loginWithFacebook();

      expect(result, isA<UserEntity>());
      expect(result.uid, tUserModel.uid);
      expect(result.email, tUserModel.email);
      verify(() => mockAuthRemoteDatasource.loginWithFacebook()).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });

    test('should throw Exception when loginWithFacebook fails', () async {
      when(() => mockAuthRemoteDatasource.loginWithFacebook()).thenThrow(Exception('Facebook error'));

      expect(
        () => authRepositoryImpl.loginWithFacebook(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Facebook login failed'))),
      );
      verify(() => mockAuthRemoteDatasource.loginWithFacebook()).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });

    test('should return UserEntity when loginWithGoogle is successful', () async {
      final tUserModel = UserModel(uid: 'ggl789', email: 'ggl@example.com', name: 'Google User');
      when(() => mockAuthRemoteDatasource.loginWithGoogle()).thenAnswer((_) async => tUserModel);

      final result = await authRepositoryImpl.loginWithGoogle();

      expect(result, isA<UserEntity>());
      expect(result.uid, tUserModel.uid);
      expect(result.email, tUserModel.email);
      verify(() => mockAuthRemoteDatasource.loginWithGoogle()).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });

    test('should throw Exception when loginWithGoogle fails', () async {
      when(() => mockAuthRemoteDatasource.loginWithGoogle()).thenThrow(Exception('Google error'));

      expect(
        () => authRepositoryImpl.loginWithGoogle(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Google login failed'))),
      );
      verify(() => mockAuthRemoteDatasource.loginWithGoogle()).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });

    test('should call logout on AuthRemoteDatasource when logout is successful', () async {
      when(() => mockAuthRemoteDatasource.logout()).thenAnswer((_) async {});

      await authRepositoryImpl.logout();

      verify(() => mockAuthRemoteDatasource.logout()).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDatasource);
    });
  });
}
