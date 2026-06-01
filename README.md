# EduCheck - Flutter

Projeto Flutter inspirado no modelo visual enviado: azul-marinho, branco, cards arredondados, SplashScreen, Login/Cadastro, Dashboard e Formulário de nova tarefa/disciplina.

## Como executar

1. Extraia o ZIP.
2. Abra a pasta no VS Code ou Android Studio.
3. Rode:

```bash
flutter pub get
flutter run
```

## Estrutura

```txt
lib/
├── main.dart
├── theme/
│   └── app_colors.dart
├── models/
│   ├── tarefa.dart
│   └── disciplina.dart
├── data/
│   └── app_data.dart
└── screens/
    ├── splash_screen.dart
    ├── login_screen.dart
    ├── home_screen.dart
    ├── nova_tarefa_screen.dart
    ├── disciplinas_screen.dart
    ├── calculadora_media_screen.dart
    └── perfil_screen.dart
```

## Observação

Esta versão usa dados em memória. Ao fechar o aplicativo, as tarefas e disciplinas cadastradas são perdidas. Para salvar permanentemente, o próximo passo seria usar SharedPreferences, Hive, SQLite ou Firebase.
