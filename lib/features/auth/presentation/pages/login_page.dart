import '../../../../core/utils/app_colors.dart';
import '../widgets/logo_custom.dart';

import '../../../../core/utils/gradient_container.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/textfield_custom.dart';
import '../../../home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_buttons/auth_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: context.linearGradientBox,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 100, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        LogoCustom(),
                        Text(
                          'Bem-vindo!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text(
                            textAlign: TextAlign.start,
                            'Aqui você gerencia seus seguros de forma fácil e rápida.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: context.backgroundMedium,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GoogleAuthButton(
                          onPressed: () {
                            context.read<AuthCubit>().loginWithGoogle();
                          },
                          style: AuthButtonStyle(buttonType: AuthButtonType.icon),
                        ),
                        FacebookAuthButton(
                          onPressed: () async {
                            context.read<AuthCubit>().loginWithFacebook();
                          },
                          style: AuthButtonStyle(buttonType: AuthButtonType.icon),
                        ),
                        TwitterAuthButton(onPressed: () {}, style: AuthButtonStyle(buttonType: AuthButtonType.icon))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Card(
                elevation: 10,
                color: context.backgroundLight,
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthAuthenticated) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => HomePage()),
                      );
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                  color: Color(0xFF2DB08D),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Cadastrar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextfieldCustom(
                          labelText: 'Email',
                          controller: _emailController,
                        ),
                        const SizedBox(height: 12),
                        TextfieldCustom(
                          labelText: 'Senha',
                          controller: _passwordController,
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                              activeColor: Color(0xFF2DB08D),
                            ),
                            const Text(
                              'Lembrar sempre',
                              style: TextStyle(color: Colors.white, fontSize: 11),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Esqueceu sua senha?',
                                style: TextStyle(color: Color(0xFF2DB08D), fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: context.linearGradientBox.copyWith(
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              final email = _emailController.text.trim();
                              final password = _passwordController.text.trim();
                              context.read<AuthCubit>().login(email, password);
                            },
                            icon: Icon(Icons.arrow_forward, color: Colors.white, size: 30),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
