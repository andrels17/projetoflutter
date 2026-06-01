import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/tarefa.dart';
import '../theme/app_colors.dart';

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
        const SnackBar(content: Text('Preencha todos os campos.')),
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
        ? 'Selecione a data'
        : '${dataSelecionada!.day.toString().padLeft(2, '0')}/${dataSelecionada!.month.toString().padLeft(2, '0')}/${dataSelecionada!.year}';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Nova Tarefa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 34, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Título da Tarefa / Disciplina',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: tituloController,
                decoration: const InputDecoration(
                  hintText: 'Título da Tarefa / Disciplina',
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Disciplina',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: disciplinaController,
                decoration: const InputDecoration(
                  hintText: 'Ex: Matemática',
                  prefixIcon: Icon(Icons.menu_book, color: AppColors.navy),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Data de Entrega',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: escolherData,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.calendar_month,
                      color: AppColors.navy,
                    ),
                  ),
                  child: Text(
                    textoData,
                    style: TextStyle(
                      color: dataSelecionada == null
                          ? Colors.grey.shade600
                          : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 34),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: salvarTarefa,
                  child: const Text(
                    'Salvar Tarefa',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/disciplinas');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Cadastrar disciplina'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
