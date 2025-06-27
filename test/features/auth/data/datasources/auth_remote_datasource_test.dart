import 'package:challenge_direct_solution/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:challenge_direct_solution/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late AuthRemoteDatasourceImpl remoteDatasourceImpl;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    remoteDatasourceImpl = AuthRemoteDatasourceImpl(
      mockGoogleSignIn,
      firebaseAuth: mockFirebaseAuth,
    );
  });

  group('AuthRemoteDatasourceImpl', () {
    test('login with email and password', () async {
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();

      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('123');
      when(() => mockUser.email).thenReturn('email@test.com');
      when(() => mockUser.displayName).thenReturn('Usuário test');
      when(() => mockUser.photoURL).thenReturn('https://foto');

      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => mockUserCredential);

      final result = await remoteDatasourceImpl.login(email: 'email@test.com', password: '123456');

      expect(result, isA<UserModel>());
      expect(result.email, 'email@test.com');

      expect(result.uid, '123');
      expect(result.name, 'Usuário test');
      expect(result.photoUrl, 'https://foto');
    });

    test('register new user', () async {
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();

      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('999');
      when(() => mockUser.email).thenReturn('new@user.com');
      when(() => mockUser.displayName).thenReturn('Novo Usuário');
      when(() => mockUser.photoURL).thenReturn(null);

      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => mockUserCredential);

      final result = await remoteDatasourceImpl.register(email: 'new@user.com', password: 'senha123');

      expect(result, isA<UserModel>());
      expect(result.uid, '999');
      expect(result.email, 'new@user.com');
      expect(result.name, 'Novo Usuário');
      expect(result.photoUrl, null);
    });

    test('getCurrentUser returns current user', () async {
      final mockUser = MockUser();

      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('321');
      when(() => mockUser.email).thenReturn('atual@user.com');
      when(() => mockUser.displayName).thenReturn('Usuário Atual');
      when(() => mockUser.photoURL).thenReturn('https://foto');

      final result = await remoteDatasourceImpl.getCurrentUser();

      expect(result, isA<UserModel>());
      expect(result.uid, '321');
      expect(result.email, 'atual@user.com');
      expect(result.name, 'Usuário Atual');
      expect(result.photoUrl, 'https://foto');
    });

    test('logout should call signOut', () async {
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});

      await remoteDatasourceImpl.logout();

      verify(() => mockFirebaseAuth.signOut()).called(1);
    });
  });
}
