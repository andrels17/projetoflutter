import 'package:flutter/material.dart';
import '../data/app_data.dart';

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

  void entrar() {
    final nome = nomeController.text.trim();
    final email = emailController.text.trim();
    final senha = senhaController.text.trim();

    if (email.isEmpty || senha.isEmpty) {
      mostrarMensagem('Preencha o e-mail e a senha.');
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
      SnackBar(
        content: Text(mensagem),
      ),
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
      backgroundColor: Colors.indigo.shade50,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.school,
                    size: 70,
                    color: Colors.indigo,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'EduCheck',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    modoCadastro ? 'Crie sua conta' : 'Entre na sua conta',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),

                  if (modoCadastro)
                    TextField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),

                  if (modoCadastro) const SizedBox(height: 16),

                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: senhaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: entrar,
                      child: Text(
                        modoCadastro ? 'Cadastrar' : 'Entrar',
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      setState(() {
                        modoCadastro = !modoCadastro;
                      });
                    },
                    child: Text(
                      modoCadastro
                          ? 'Já tenho conta. Fazer login'
                          : 'Não tenho conta. Cadastrar',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
