import 'package:challenge_direct_solution/features/auth/domain/entities/user_entity.dart';
import 'package:challenge_direct_solution/features/auth/domain/repositories/auth_repository.dart';
import 'package:challenge_direct_solution/features/auth/domain/usecases/auth_usecase_get_current_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthUsecaseGetCurrentUser usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = AuthUsecaseGetCurrentUser(authRepository: mockAuthRepository);
  });

  group('AuthUsecaseGetCurrentUser', () {
    test('should return UserEntity when repository call is successful', () async {
      final tUser = UserEntity(
        uid: '123',
        email: 'user@example.com',
        name: 'User',
        photoUrl: 'http://photo.com/user.jpg',
      );
      when(() => mockAuthRepository.getCurrentUser()).thenAnswer((_) async => tUser);

      final result = await usecase();

      expect(result, equals(tUser));
      verify(() => mockAuthRepository.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should throw Exception when repository throws error', () async {
      when(() => mockAuthRepository.getCurrentUser()).thenThrow(Exception('No user'));

      expect(
        () => usecase(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Failed to get current user'))),
      );
      verify(() => mockAuthRepository.getCurrentUser()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
