Challenge Direct Solution: Autenticação Segura e Arquitetura Limpa com Flutter
Este projeto Flutter oferece uma solução robusta para autenticação de usuários, integrando Firebase Authentication, Google Sign-In e Facebook Login. Ele é construído sobre os princípios da Clean Architecture, garantindo um código organizado, testável e de fácil manutenção. Para gerenciamento de estado, utilizamos Cubit, e para injeção de dependências, contamos com o GetIt.

📦 Estrutura do Projeto
A organização do código segue a Clean Architecture, promovendo a separação de responsabilidades e a modularidade:

```
lib/
├── core/
│   └── utils/                     
│       ├── app_colors.dart          # Definições de cores utilizadas no app
│       ├── app_strings.dart         # Constantes de textos e mensagens
│       └── gradient_container.dart  # Widget reutilizável com gradiente
│
├── features/
│   ├── auth/                      
│   │   ├── data/                 
│   │   │   ├── datasources/       
│   │   │   │   └── auth_remote_datasource.dart   # Comunicação com Firebase, Google, Facebook
│   │   │   ├── models/            
│   │   │   │   └── user_model.dart                # Conversão FirebaseUser para UserModel
│   │   │   └── repositories/      
│   │   │       └── auth_repository_impl.dart      # Implementação do AuthRepository
│   │   │
│   │   ├── domain/
│   │   │   ├── entities/          
│   │   │   │   └── user_entity.dart               # Entidade base do usuário
│   │   │   ├── repositories/      
│   │   │   │   └── auth_repository.dart           # Contrato de repositório de auth
│   │   │   └── usecases/          
│   │   │       ├── auth_usecase_get_current_user.dart
│   │   │       ├── auth_usecase_login.dart
│   │   │       ├── auth_usecase_login_with_facebook.dart
│   │   │       ├── auth_usecase_login_with_google.dart
│   │   │       ├── auth_usecase_logout.dart
│   │   │       └── auth_usecase_register.dart
│   │   │
│   │   └── presentation/
│   │       ├── cubit/             
│   │       │   ├── auth_cubit.dart                  # Gerencia o estado da autenticação
│   │       │   └── auth_state.dart                  # Estados usados pelo AuthCubit
│   │       └── pages/             
│   │           └── login_page.dart                  # Tela de login
│
│   └── home/
│       └── presentation/
│           ├── pages/
│           │   └── home_page.dart                   # Tela principal após login
│           └── widgets/                             # Componentes reutilizáveis da Home
│              
│
├── injection/                     
│   └── injection_container.dart    # Setup do GetIt para injeção de dependência
│
├── firebase_options.dart           # Arquivo gerado com as configs do Firebase
│
└── main.dart
```          


## 🚀 Como Instalar o Flutter e Rodar o Projeto

### 1. Instalar o Flutter
Certifique-se de instalar o Flutter na versão **3.27.2** (ou superior). Siga os passos abaixo:

- [Guia oficial de instalação do Flutter](https://docs.flutter.dev/get-started/install)
- Após a instalação, verifique se o Flutter está configurado corretamente:
  ```bash
  flutter doctor
  ```

### 2. Clonar o Repositório
Clone este repositório em sua máquina local:
```bash
git clone https://github.com/ManoelASNeto/challenge_tpc.git
cd challenge_tpc
```

### 3. Instalar Dependências
Rode o comando abaixo para instalar todas as dependências do projeto:
```bash
flutter pub get
```

### 4. Rodar o Projeto
Para rodar o projeto em um dispositivo ou emulador:
```bash
flutter run
```

---
### 🛠️ Tecnologias Principais
### **GetIt para Injeção de Dependências**
O GetIt é a espinha dorsal da nossa injeção de dependências. Ele simplifica o processo de registrar e recuperar instâncias de classes, como repositórios, datasources e casos de uso, tornando o código mais desacoplado e fácil de testar.

**Exemplo de Configuração:**

```Dart

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(firebaseAuth: FirebaseAuth.instance, googleSignIn: GoogleSignIn()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authRemoteDatasource: getIt()));
  getIt.registerLazySingleton<AuthUsecaseLogin>(() => AuthUsecaseLogin(authRepository: getIt()));
  // ... e assim por diante para outros usecases e cubits
}
```

**Cubit para Gerenciamento de Estado**

O Cubit é utilizado para gerenciar os estados das telas relacionadas à autenticação. Ele oferece uma abordagem simples e eficiente para lidar com as diferentes fases da UI (carregamento, sucesso, erro).

Exemplo de Cubit:

```Dart

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecaseLogin usecaseLogin;

  AuthCubit(this.usecaseLogin) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading()); // Emite estado de carregamento
    try {
      final user = await usecaseLogin.call(email, password);
      emit(AuthAuthenticated(user: user)); // Emite estado de sucesso com o usuário
    } catch (error) {
      emit(AuthError(message: error.toString())); // Emite estado de erro
    }
  }
}
```

## 🧪 Testes e Cobertura de Código
Garantimos a qualidade do código através de testes unitários abrangentes, seguindo as melhores práticas da Clean Architecture.

### 1.Rodar os Testes
Para executar todos os testes do projeto, use o comando:

```Bash

flutter test
```

### 2. Gerar Relatório de Cobertura de Testes
Para analisar a cobertura de testes com lcov, siga os passos:

 1. Instale o lcov (se ainda não tiver):

```Bash

sudo apt-get install lcov  # Para Linux
brew install lcov          # Para macOS
```

2. Rode os testes com cobertura:

Bash

flutter test --coverage
3. Gere o relatório HTML:

```Bash

genhtml coverage/lcov.info -o coverage/html
```

4. Abra o relatório no navegador:

```Bash

open coverage/html/index.html
```

📸 Capturas de Tela
Confira o aplicativo em ação:


![Captura de Tela 2025-06-27 às 11 45 00](https://github.com/user-attachments/assets/acab019b-8ca9-4b4e-a6c6-e272bfff1194)


![Captura de Tela 2025-06-27 às 11 45 27](https://github.com/user-attachments/assets/29efba08-ab56-4673-b1b1-e60e514a8c6e)

![Captura de Tela 2025-06-27 às 11 45 34](https://github.com/user-attachments/assets/0143178a-2022-4d95-8e63-d6336b66a121)



Exportar para as Planilhas
Tela Principal (Pós-Autenticação)
Bem-vindo!



## 📝 Conclusão
Este projeto serve como uma demonstração prática da integração do Flutter com Firebase para autenticação, aplicando rigorosamente os princípios da Clean Architecture. Com o uso do Cubit para gerenciamento de estado e GetIt para injeção de dependências, garantimos que a aplicação não só seja funcional, mas também altamente manutenível, escalável e testável.


