import 'package:challenge_direct_solution/features/auth/domain/entities/user_entity.dart';
import 'package:challenge_direct_solution/features/auth/domain/repositories/auth_repository.dart';
import 'package:challenge_direct_solution/features/auth/domain/usecases/auth_usecase_register.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthUsecaseRegister registerUsecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    registerUsecase = AuthUsecaseRegister(authRepository: mockAuthRepository);
  });

  group('AuthUsecaseRegister', () {
    test('should return UserEntity when register is successful', () async {
      final tEmail = 'new@example.com';
      final tPassword = 'newpass';
      final tUser = UserEntity(
        uid: '456',
        email: tEmail,
        name: 'New User',
        photoUrl: 'http://photo.com/new.jpg',
      );
      when(() => mockAuthRepository.register(email: tEmail, password: tPassword)).thenAnswer((_) async => tUser);

      final result = await registerUsecase(tEmail, tPassword);

      expect(result, equals(tUser));
      verify(() => mockAuthRepository.register(email: tEmail, password: tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should throw Exception when register fails', () async {
      final tEmail = 'new@example.com';
      final tPassword = 'newpass';
      when(() => mockAuthRepository.register(email: tEmail, password: tPassword))
          .thenThrow(Exception('Registration error'));

      expect(
        () => registerUsecase(tEmail, tPassword),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Registration error'))),
      );
      verify(() => mockAuthRepository.register(email: tEmail, password: tPassword)).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
