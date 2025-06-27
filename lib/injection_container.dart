import 'package:challenge_direct_solution/features/auth/domain/usecases/auth_usecase_login_with_google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/auth_usecase_get_current_user.dart';
import 'features/auth/domain/usecases/auth_usecase_login.dart';
import 'features/auth/domain/usecases/auth_usecase_login_with_facebook.dart';
import 'features/auth/domain/usecases/auth_usecase_logout.dart';
import 'features/auth/domain/usecases/auth_usecase_register.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Firebase Auth
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<GoogleSignIn>(GoogleSignIn());

  sl.registerSingleton<AuthRemoteDatasource>(
    AuthRemoteDatasourceImpl(
      sl<GoogleSignIn>(),
      firebaseAuth: sl(),
    ),
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      authRemoteDatasource: sl(),
    ),
  );

  // Use cases
  sl.registerSingleton(
    AuthUsecaseGetCurrentUser(
      authRepository: sl(),
    ),
  );
  sl.registerSingleton(
    AuthUsecaseLogin(
      authRepository: sl(),
    ),
  );
  sl.registerSingleton(
    AuthUsecaseRegister(
      authRepository: sl(),
    ),
  );
  sl.registerSingleton(
    AuthUsecaseLogout(
      authRepository: sl(),
    ),
  );

  sl.registerSingleton(AuthUsecaseLoginWithFacebook(
    authRepository: sl(),
  ));

  sl.registerSingleton(AuthUsecaseLoginWithGoogle(
    authRepository: sl(),
  ));

  sl.registerSingleton(
    AuthCubit(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
    ),
  );
  await sl.allReady();
}
