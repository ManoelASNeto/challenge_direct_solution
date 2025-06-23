import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({required String email, required String password});
  Future<void> logout();
  Future<UserModel> getCurrentUser();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDatasourceImpl({required this.firebaseAuth});

  @override
  Future<UserModel> getCurrentUser() {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      return Future.value(UserModel(email: user.email ?? '', password: ''));
    } else {
      return Future.error('No user is currently signed in');
    }
  }

  @override
  Future<UserModel> login({required String email, required String password}) {
    return firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((userCredential) {
      final user = userCredential.user;
      if (user != null) {
        return UserModel(email: user.email ?? '', password: password);
      } else {
        throw Exception('User not found');
      }
    }).catchError((error) {
      throw Exception('Login failed: $error');
    });
  }

  @override
  Future<UserModel> register({required String email, required String password}) {
    return firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((userCredential) {
      final user = userCredential.user;
      if (user != null) {
        return UserModel(email: user.email ?? '', password: password);
      } else {
        throw Exception('User not created');
      }
    }).catchError((error) {
      throw Exception('Registration failed: $error');
    });
  }

  @override
  Future<void> logout() {
    return firebaseAuth.signOut().catchError((error) {
      throw Exception('Logout failed: $error');
    });
  }
}
