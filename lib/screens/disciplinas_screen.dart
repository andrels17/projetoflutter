import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/disciplina.dart';
import '../theme/app_colors.dart';

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
        const SnackBar(content: Text('Preencha todos os campos.')),
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
  }

  void removerDisciplina(int index) {
    setState(() {
      AppData.disciplinas.removeAt(index);
    });
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
    final disciplinas = AppData.disciplinas;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Disciplinas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
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
                        prefixIcon: Icon(Icons.menu_book, color: AppColors.navy),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: professorController,
                      decoration: const InputDecoration(
                        labelText: 'Professor',
                        prefixIcon: Icon(Icons.person, color: AppColors.navy),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: horarioController,
                      decoration: const InputDecoration(
                        labelText: 'Horário',
                        hintText: 'Ex: Segunda e Quarta - 08:00',
                        prefixIcon: Icon(Icons.access_time, color: AppColors.navy),
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
            const SizedBox(height: 18),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Disciplinas cadastradas',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (disciplinas.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Nenhuma disciplina cadastrada.'),
                ),
              )
            else
              ListView.separated(
                itemCount: disciplinas.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final disciplina = disciplinas[index];

                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.navy,
                        child: Icon(Icons.school, color: Colors.white),
                      ),
                      title: Text(
                        disciplina.nome,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Professor: ${disciplina.professor}\nHorário: ${disciplina.horario}',
                      ),
                      isThreeLine: true,
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removerDisciplina(index),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
