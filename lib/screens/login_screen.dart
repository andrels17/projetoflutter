import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool modoCadastro = false;
  bool mostrarSenha = false;

  void entrar() {
    final nome = nomeController.text.trim();
    final email = emailController.text.trim();
    final senha = senhaController.text.trim();

    if (email.isEmpty || senha.isEmpty) {
      mostrarMensagem('Preencha o e-mail/matrícula e a senha.');
      return;
    }

    if (modoCadastro && nome.isEmpty) {
      mostrarMensagem('Preencha o nome para cadastrar.');
      return;
    }

    if (modoCadastro) {
      AppData.nomeUsuario = nome;
    }

    AppData.emailUsuario = email;

    Navigator.pushReplacementNamed(context, '/home');
  }

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Text(
                  modoCadastro ? 'Cadastro EduCheck' : 'Bem-vindo ao\nEduCheck',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.navy,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    height: 1.12,
                  ),
                ),
                const SizedBox(height: 38),

                if (modoCadastro) ...[
                  TextField(
                    controller: nomeController,
                    decoration: const InputDecoration(
                      hintText: 'Nome completo',
                      prefixIcon: Icon(Icons.person, color: AppColors.navy),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'E-mail ou Matrícula',
                    prefixIcon: Icon(Icons.email, color: AppColors.navy),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: senhaController,
                  obscureText: !mostrarSenha,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    prefixIcon: const Icon(Icons.lock, color: AppColors.navy),
                    suffixIcon: IconButton(
                      icon: Icon(
                        mostrarSenha ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          mostrarSenha = !mostrarSenha;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: entrar,
                    child: Text(
                      modoCadastro ? 'Cadastrar' : 'Entrar',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      modoCadastro ? 'Já tem conta? ' : 'Não tem conta? ',
                      style: const TextStyle(color: Colors.black87),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          modoCadastro = !modoCadastro;
                        });
                      },
                      child: Text(
                        modoCadastro ? 'Entrar' : 'Cadastre-se aqui',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
