import 'package:flutter/material.dart';
import '../data/app_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int get totalTarefas => AppData.tarefas.length;

  int get tarefasPendentes {
    return AppData.tarefas.where((tarefa) => !tarefa.concluida).length;
  }

  int get totalDisciplinas => AppData.disciplinas.length;

  Future<void> abrirTela(String rota) async {
    await Navigator.pushNamed(context, rota);
    setState(() {});
  }

  void removerTarefa(int index) {
    setState(() {
      AppData.tarefas.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tarefa removida com sucesso.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EduCheck'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              abrirTela('/perfil');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Olá, ${AppData.nomeUsuario}!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Aqui está o resumo da sua rotina acadêmica.',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.task,
                        color: Colors.indigo,
                      ),
                      title: Text('$tarefasPendentes'),
                      subtitle: const Text('Tarefas pendentes'),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.menu_book,
                        color: Colors.indigo,
                      ),
                      title: Text('$totalDisciplinas'),
                      subtitle: const Text('Disciplinas'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    abrirTela('/nova-tarefa');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Nova tarefa'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    abrirTela('/disciplinas');
                  },
                  icon: const Icon(Icons.menu_book),
                  label: const Text('Disciplinas'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    abrirTela('/calculadora');
                  },
                  icon: const Icon(Icons.calculate),
                  label: const Text('Médias'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Tarefas cadastradas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: AppData.tarefas.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhuma tarefa cadastrada ainda.',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: AppData.tarefas.length,
                      itemBuilder: (context, index) {
                        final tarefa = AppData.tarefas[index];

                        return Card(
                          child: CheckboxListTile(
                            title: Text(
                              tarefa.titulo,
                              style: TextStyle(
                                decoration: tarefa.concluida
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            subtitle: Text(
                              '${tarefa.disciplina} | Entrega: ${tarefa.dataEntrega.day}/${tarefa.dataEntrega.month}/${tarefa.dataEntrega.year}',
                            ),
                            value: tarefa.concluida,
                            onChanged: (valor) {
                              setState(() {
                                tarefa.concluida = valor ?? false;
                              });
                            },
                            secondary: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                removerTarefa(index);
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
