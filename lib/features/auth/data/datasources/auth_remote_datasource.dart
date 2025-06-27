import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> getCurrentUser();
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> register({required String email, required String password});
  Future<UserModel> loginWithFacebook();
  Future<void> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDatasourceImpl({required this.firebaseAuth});

  @override
  Future<UserModel> getCurrentUser() {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      return Future.value(UserModel.fromFirebaseUser(user));
    } else {
      return Future.error('No user is currently signed in');
    }
  }

  @override
  Future<UserModel> login({required String email, required String password}) {
    return firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((userCredential) {
      final user = userCredential.user;
      if (user != null) {
        return UserModel.fromFirebaseUser(user);
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
        return UserModel.fromFirebaseUser(user);
      } else {
        throw Exception('User not created');
      }
    }).catchError((error) {
      throw Exception('Registration failed: $error');
    });
  }

  @override
  Future<UserModel> loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData(
        fields: "name,email,picture.width(200)",
      );

      return UserModel(
        uid: userData['id'] ?? '',
        name: userData['name'] ?? '',
        email: userData['email'] ?? '',
        photoUrl: userData['picture']['data']['url'],
      );
    } else {
      throw Exception('Facebook login failed: ${result.status}');
    }
  }

  @override
  Future<void> logout() {
    return firebaseAuth.signOut().catchError((error) {
      throw Exception('Logout failed: $error');
    });
  }
}
