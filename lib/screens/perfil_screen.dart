import 'package:flutter/material.dart';
import '../data/app_data.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  late TextEditingController nomeController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    nomeController = TextEditingController(text: AppData.nomeUsuario);
    emailController = TextEditingController(text: AppData.emailUsuario);
  }

  void salvarPerfil() {
    final nome = nomeController.text.trim();
    final email = emailController.text.trim();

    if (nome.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos.'),
        ),
      );
      return;
    }

    setState(() {
      AppData.nomeUsuario = nome;
      AppData.emailUsuario = email;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil atualizado com sucesso.'),
      ),
    );
  }

  void sair() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (route) => false,
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalTarefas = AppData.tarefas.length;
    final totalDisciplinas = AppData.disciplinas.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.indigo,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 55,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.indigo.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.task,
                                color: Colors.indigo,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '$totalTarefas',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text('Tarefas'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        color: Colors.indigo.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.menu_book,
                                color: Colors.indigo,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '$totalDisciplinas',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text('Disciplinas'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: salvarPerfil,
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar perfil'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: sair,
                    icon: const Icon(Icons.logout),
                    label: const Text('Sair'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
