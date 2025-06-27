import 'package:challenge_direct_solution/core/routes/routes.dart';
import 'package:challenge_direct_solution/features/auth/presentation/cubit/auth_cubit.dart';

import 'core/routes/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'injection_container.dart' as sl;
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await sl.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => sl.sl<AuthCubit>(),
      child: MaterialApp(
        onGenerateRoute: _router.generateRoutes,
        initialRoute: Routes.login,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
