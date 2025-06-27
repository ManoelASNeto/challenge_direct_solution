import 'package:challenge_direct_solution/features/auth/domain/repositories/auth_repository.dart';
import 'package:challenge_direct_solution/features/auth/domain/usecases/auth_usecase_logout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;

  late AuthUsecaseLogout logoutUsecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    logoutUsecase = AuthUsecaseLogout(authRepository: mockAuthRepository);
  });

  group('AuthUsecaseLogout', () {
    test('should call logout on repository', () async {
      when(() => mockAuthRepository.logout()).thenAnswer((_) async {});

      await logoutUsecase();

      verify(() => mockAuthRepository.logout()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should throw Exception when logout fails', () async {
      when(() => mockAuthRepository.logout()).thenThrow(Exception('Logout error'));

      expect(
        () => logoutUsecase(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Logout failed'))),
      );
      verify(() => mockAuthRepository.logout()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
