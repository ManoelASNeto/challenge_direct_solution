import 'package:challenge_direct_solution/features/auth/domain/entities/user_entity.dart';
import 'package:challenge_direct_solution/features/auth/domain/repositories/auth_repository.dart';
import 'package:challenge_direct_solution/features/auth/domain/usecases/auth_usecase_login_with_facebook.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthUsecaseLoginWithFacebook authUsecaseLoginWithFacebook;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authUsecaseLoginWithFacebook = AuthUsecaseLoginWithFacebook(authRepository: mockAuthRepository);
  });

  group('AuthUsecaseLoginWithFacebook', () {
    final tUserEntity = UserEntity(
      uid: 'facebook-id-123',
      email: 'facebook@example.com',
      name: 'Facebook User',
    );

    test('should call loginWithFacebook on the repository and return a UserEntity', () async {
      when(() => mockAuthRepository.loginWithFacebook()).thenAnswer((_) async => tUserEntity);

      final result = await authUsecaseLoginWithFacebook.call();

      expect(result, isA<UserEntity>());
      expect(result, tUserEntity);
      verify(() => mockAuthRepository.loginWithFacebook()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should re-throw any exception thrown by the repository', () async {
      final tException = Exception('Facebook login failed from repository');
      when(() => mockAuthRepository.loginWithFacebook()).thenThrow(tException);

      expect(
        () => authUsecaseLoginWithFacebook.call(),
        throwsA(tException),
      );
      verify(() => mockAuthRepository.loginWithFacebook()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
