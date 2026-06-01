import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/tarefa.dart';

class NovaTarefaScreen extends StatefulWidget {
  const NovaTarefaScreen({super.key});

  @override
  State<NovaTarefaScreen> createState() => _NovaTarefaScreenState();
}

class _NovaTarefaScreenState extends State<NovaTarefaScreen> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController disciplinaController = TextEditingController();

  DateTime? dataSelecionada;

  Future<void> escolherData() async {
    final DateTime? data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2035),
    );

    if (data != null) {
      setState(() {
        dataSelecionada = data;
      });
    }
  }

  void salvarTarefa() {
    final titulo = tituloController.text.trim();
    final disciplina = disciplinaController.text.trim();

    if (titulo.isEmpty || disciplina.isEmpty || dataSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos.'),
        ),
      );
      return;
    }

    AppData.tarefas.add(
      Tarefa(
        titulo: titulo,
        disciplina: disciplina,
        dataEntrega: dataSelecionada!,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tarefa cadastrada com sucesso.'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    tituloController.dispose();
    disciplinaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textoData = dataSelecionada == null
        ? 'Nenhuma data selecionada'
        : '${dataSelecionada!.day}/${dataSelecionada!.month}/${dataSelecionada!.year}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Tarefa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                TextField(
                  controller: tituloController,
                  decoration: const InputDecoration(
                    labelText: 'Título da tarefa',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.task),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: disciplinaController,
                  decoration: const InputDecoration(
                    labelText: 'Disciplina',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.menu_book),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.calendar_month,
                    color: Colors.indigo,
                  ),
                  title: const Text('Data de entrega'),
                  subtitle: Text(textoData),
                  trailing: ElevatedButton(
                    onPressed: escolherData,
                    child: const Text('Escolher'),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: salvarTarefa,
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar tarefa'),
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
