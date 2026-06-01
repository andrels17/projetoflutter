import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/disciplina.dart';

class DisciplinasScreen extends StatefulWidget {
  const DisciplinasScreen({super.key});

  @override
  State<DisciplinasScreen> createState() => _DisciplinasScreenState();
}

class _DisciplinasScreenState extends State<DisciplinasScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController professorController = TextEditingController();
  final TextEditingController horarioController = TextEditingController();

  void salvarDisciplina() {
    final nome = nomeController.text.trim();
    final professor = professorController.text.trim();
    final horario = horarioController.text.trim();

    if (nome.isEmpty || professor.isEmpty || horario.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos.'),
        ),
      );
      return;
    }

    setState(() {
      AppData.disciplinas.add(
        Disciplina(
          nome: nome,
          professor: professor,
          horario: horario,
        ),
      );

      nomeController.clear();
      professorController.clear();
      horarioController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Disciplina cadastrada com sucesso.'),
      ),
    );
  }

  void removerDisciplina(int index) {
    setState(() {
      AppData.disciplinas.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Disciplina removida.'),
      ),
    );
  }

  @override
  void dispose() {
    nomeController.dispose();
    professorController.dispose();
    horarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disciplinas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    TextField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome da disciplina',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.menu_book),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: professorController,
                      decoration: const InputDecoration(
                        labelText: 'Professor',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: horarioController,
                      decoration: const InputDecoration(
                        labelText: 'Horário',
                        hintText: 'Ex: Segunda e Quarta - 08:00',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.access_time),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: salvarDisciplina,
                        icon: const Icon(Icons.save),
                        label: const Text('Salvar disciplina'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Disciplinas cadastradas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: AppData.disciplinas.isEmpty
                  ? const Center(
                      child: Text('Nenhuma disciplina cadastrada.'),
                    )
                  : ListView.builder(
                      itemCount: AppData.disciplinas.length,
                      itemBuilder: (context, index) {
                        final disciplina = AppData.disciplinas[index];

                        return Card(
                          child: ListTile(
                            leading: const Icon(
                              Icons.school,
                              color: Colors.indigo,
                            ),
                            title: Text(disciplina.nome),
                            subtitle: Text(
                              'Professor: ${disciplina.professor}\nHorário: ${disciplina.horario}',
                            ),
                            isThreeLine: true,
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                removerDisciplina(index);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
