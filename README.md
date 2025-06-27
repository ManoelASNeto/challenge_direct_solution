# Challenge Direct Solution

Este é um aplicativo Flutter com foco em autenticação (Firebase, Google, Facebook) e arquitetura limpa (Clean Architecture) para gerenciar usuários. O projeto utiliza Cubit para gerenciamento de estado, Firebase Authentication para login, e GetIt para injeção de dependências.

📦 Estrutura do Projeto  
O projeto está organizado da seguinte forma:

lib/
├── core/
│ └── utils/
│ ├── app_colors.dart
│ └── app_strings.dart
├── features/
│ └── auth/
│ ├── data/
│ │ ├── datasources/
│ │ │ └── auth_remote_datasource.dart
│ │ ├── models/
│ │ │ └── user_model.dart
│ │ └── repositories/
│ │ └── auth_repository_impl.dart
│ ├── domain/
│ │ ├── entities/
│ │ │ └── user_entity.dart
│ │ ├── repositories/
│ │ │ └── auth_repository.dart
│ │ └── usecases/
│ │ ├── auth_usecase_get_current_user.dart
│ │ ├── auth_usecase_login.dart
│ │ ├── auth_usecase_register.dart
│ │ ├── auth_usecase_login_with_facebook.dart
│ │ ├── auth_usecase_login_with_google.dart
│ │ └── auth_usecase_logout.dart
│ └── presentation/
│ ├── cubit/
│ │ ├── auth_cubit.dart
│ │ └── auth_state.dart
│ └── pages/
│ ├── login_page.dart


less
Copiar
Editar

🚀 Como Instalar o Flutter e Rodar o Projeto  
1. Instalar o Flutter  
Certifique-se de instalar o Flutter na versão 3.27.2 (ou superior).  
Siga o passo a passo do [Guia oficial de instalação do Flutter](https://flutter.dev/docs/get-started/install).  

Após a instalação, verifique se está tudo certo:  
```bash
flutter doctor
Clonar o Repositório

bash
Copiar
Editar
git clone https://github.com/ManoelASNeto/challenge_direct_solution.git
cd challenge_direct_solution
Instalar Dependências

bash
Copiar
Editar
flutter pub get
Rodar o Projeto
Rode o app no dispositivo ou emulador:

bash
Copiar
Editar
flutter run
🛠️ Uso de GetIt e Cubit

GetIt
Utilizado para injeção de dependências, facilitando o registro e a recuperação das instâncias, como repositórios, datasources e casos de uso.

Exemplo de configuração:

dart
Copiar
Editar
final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(firebaseAuth: FirebaseAuth.instance, googleSignIn: GoogleSignIn()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authRemoteDatasource: getIt()));
  getIt.registerLazySingleton<AuthUsecaseLogin>(() => AuthUsecaseLogin(authRepository: getIt()));
  // Outros registros de usecases e cubits
}
Cubit
Gerencia os estados das telas relacionadas à autenticação de forma simples e eficiente.

Exemplo de Cubit:

dart
Copiar
Editar
class AuthCubit extends Cubit<AuthState> {
  final AuthUsecaseLogin usecaseLogin;

  AuthCubit(this.usecaseLogin) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await usecaseLogin.call(email, password);
      emit(AuthAuthenticated(user: user));
    } catch (error) {
      emit(AuthError(message: error.toString()));
    }
  }
}
🧪 Como Rodar os Testes e Cobertura de Testes

Rodar os Testes
Para rodar todos os testes do projeto, use:

bash
Copiar
Editar
flutter test
Gerar Cobertura de Testes
Para gerar o relatório de cobertura com o lcov, siga:

Instale o lcov (caso não tenha):

bash
Copiar
Editar
sudo apt-get install lcov  # Linux  
brew install lcov          # macOS  
Rode os testes com cobertura:

bash
Copiar
Editar
flutter test --coverage
Gere o relatório HTML:

bash
Copiar
Editar
genhtml coverage/lcov.info -o coverage/html
Abra no navegador:

bash
Copiar
Editar
open coverage/html/index.html
📸 Prints ou Vídeo
Tela de Login

Screenshot 1

Screenshot 2

Tela de Registro

Screenshot 1

Tela Principal

Screenshot 1

📝 Conclusão
Este projeto demonstra a integração do Flutter com Firebase para autenticação, utilizando Clean Architecture, Cubit para gerenciamento de estado, e GetIt para injeção de dependências. A arquitetura modular garante manutenção e escalabilidade facilitadas.
