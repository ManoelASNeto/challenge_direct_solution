import 'package:challenge_direct_solution/features/auth/domain/entities/user_entity.dart';
import 'package:challenge_direct_solution/features/auth/domain/repositories/auth_repository.dart';
import 'package:challenge_direct_solution/features/auth/domain/usecases/auth_usecase_login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;

  late AuthUsecaseLogin loginUsecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();

    loginUsecase = AuthUsecaseLogin(authRepository: mockAuthRepository);
  });

  group('AuthUsecaseLogin', () {
    test('should return UserEntity when login is successful', () async {
      final tEmail = 'test@example.com';
      final tPassword = 'password123';
      final tUser = UserEntity(
        uid: '123',
        email: tEmail,
        name: 'Test User',
        photoUrl: 'http://photo.com/test.jpg',
      );
      when(() => mockAuthRepository.login(email: tEmail, password: tPassword)).thenAnswer((_) async => tUser);

      final result = await loginUsecase(tEmail, tPassword);

      expect(result, equals(tUser));
      verify(() => mockAuthRepository.login(email: tEmail, password: tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should throw Exception when login fails', () async {
      final tEmail = 'test@example.com';
      final tPassword = 'password123';
      when(() => mockAuthRepository.login(email: tEmail, password: tPassword))
          .thenThrow(Exception('Invalid credentials'));

      expect(
        () => loginUsecase(tEmail, tPassword),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Login failed'))),
      );
      verify(() => mockAuthRepository.login(email: tEmail, password: tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
