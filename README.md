Challenge Direct Solution: Autenticação Segura e Arquitetura Limpa com Flutter
Este projeto Flutter oferece uma solução robusta para autenticação de usuários, integrando Firebase Authentication, Google Sign-In e Facebook Login. Ele é construído sobre os princípios da Clean Architecture, garantindo um código organizado, testável e de fácil manutenção. Para gerenciamento de estado, utilizamos Cubit, e para injeção de dependências, contamos com o GetIt.

📦 Estrutura do Projeto
A organização do código segue a Clean Architecture, promovendo a separação de responsabilidades e a modularidade:

lib/
├── core/
│   └── utils/                     # Utilitários e constantes (cores, strings)
├── features/
│   └── auth/                      # Módulo de Autenticação
│       ├── data/
│       │   ├── datasources/       # Fontes de dados (remota)
│       │   ├── models/            # Modelos de dados (conversão da API para a entidade)
│       │   └── repositories/      # Implementação do contrato do repositório
│       ├── domain/
│       │   ├── entities/          # Entidades de negócio (independente de infraestrutura)
│       │   ├── repositories/      # Contratos de repositório (interface)
│       │   └── usecases/          # Casos de uso (regras de negócio da aplicação)
│       └── presentation/
│           ├── cubit/             # Gerenciamento de estado com Cubit
│           └── pages/             # Telas da interface do usuário
└── ...
🚀 Como Colocar o Projeto para Rodar
1. Instalar o Flutter
Certifique-se de ter o Flutter instalado na versão 3.27.2 ou superior. Se precisar de ajuda, o Guia oficial de instalação do Flutter é seu melhor amigo!

Após a instalação, verifique se está tudo em ordem:

Bash

flutter doctor
2. Clonar o Repositório
Pegue o código mais recente do projeto:

Bash

git clone https://github.com/ManoelASNeto/challenge_direct_solution.git
cd challenge_direct_solution
3. Instalar Dependências
Entre na pasta do projeto e instale todas as dependências:

Bash

flutter pub get
4. Rodar o Projeto
Conecte um dispositivo ou inicie um emulador e execute o aplicativo:

Bash

flutter run
🛠️ Tecnologias Principais
GetIt para Injeção de Dependências
O GetIt é a espinha dorsal da nossa injeção de dependências. Ele simplifica o processo de registrar e recuperar instâncias de classes, como repositórios, datasources e casos de uso, tornando o código mais desacoplado e fácil de testar.

Exemplo de Configuração:

Dart

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(firebaseAuth: FirebaseAuth.instance, googleSignIn: GoogleSignIn()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authRemoteDatasource: getIt()));
  getIt.registerLazySingleton<AuthUsecaseLogin>(() => AuthUsecaseLogin(authRepository: getIt()));
  // ... e assim por diante para outros usecases e cubits
}
Cubit para Gerenciamento de Estado
O Cubit é utilizado para gerenciar os estados das telas relacionadas à autenticação. Ele oferece uma abordagem simples e eficiente para lidar com as diferentes fases da UI (carregamento, sucesso, erro).

Exemplo de Cubit:

Dart

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
🧪 Testes e Cobertura de Código
Garantimos a qualidade do código através de testes unitários abrangentes, seguindo as melhores práticas da Clean Architecture.

Rodar os Testes
Para executar todos os testes do projeto, use o comando:

Bash

flutter test
Gerar Relatório de Cobertura de Testes
Para analisar a cobertura de testes com lcov, siga os passos:

Instale o lcov (se ainda não tiver):

Bash

sudo apt-get install lcov  # Para Linux
brew install lcov          # Para macOS
Rode os testes com cobertura:

Bash

flutter test --coverage
Gere o relatório HTML:

Bash

genhtml coverage/lcov.info -o coverage/html
Abra o relatório no navegador:

Bash

open coverage/html/index.html
📸 Capturas de Tela
Confira o aplicativo em ação:

Tela de Login
Login com Credenciais

Login com Google


Exportar para as Planilhas
Tela de Registro
Registro de Novo Usuário


Exportar para as Planilhas
Tela Principal (Pós-Autenticação)
Bem-vindo!


Exportar para as Planilhas
📝 Conclusão
Este projeto serve como uma demonstração prática da integração do Flutter com Firebase para autenticação, aplicando rigorosamente os princípios da Clean Architecture. Com o uso do Cubit para gerenciamento de estado e GetIt para injeção de dependências, garantimos que a aplicação não só seja funcional, mas também altamente manutenível, escalável e testável.

Tem alguma pergunta ou sugestão sobre a arquitetura ou implementação? Sinta-se à vontade para contribuir!
