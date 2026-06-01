# Como rodar no FlutLab

1. Importe este ZIP como projeto Flutter.
2. Aguarde o projeto abrir.
3. No terminal, rode:

```bash
flutter clean
flutter pub get
flutter run
```

Se a tela do emulador ficar preta:
- Clique em Stop.
- Clique no botão de reiniciar/reload do emulador.
- Rode novamente `flutter run`.

Correções aplicadas nesta versão:
- `CardTheme` corrigido para `CardThemeData`.
- Temas Android ajustados para evitar tela preta.
- Tema de splash Android 12+ adicionado.
- `values-night` adicionado para evitar tema escuro/black screen.
