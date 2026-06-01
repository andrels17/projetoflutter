import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/nova_tarefa_screen.dart';
import 'screens/disciplinas_screen.dart';
import 'screens/calculadora_media_screen.dart';
import 'screens/perfil_screen.dart';

void main() {
  runApp(const EduCheckApp());
}

class EduCheckApp extends StatelessWidget {
  const EduCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduCheck',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          primary: Colors.indigo,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/nova-tarefa': (context) => const NovaTarefaScreen(),
        '/disciplinas': (context) => const DisciplinasScreen(),
        '/calculadora': (context) => const CalculadoraMediaScreen(),
        '/perfil': (context) => const PerfilScreen(),
      },
    );
  }
}
