import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController n1Controller = TextEditingController();
  final TextEditingController n2Controller = TextEditingController();
  final TextEditingController n3Controller = TextEditingController();

  double? media;
  String situacao = '';

  Future<void> abrirTela(String rota) async {
    await Navigator.pushNamed(context, rota);
    setState(() {});
  }

  int diasRestantes(DateTime data) {
    final hoje = DateTime.now();
    final hojeLimpo = DateTime(hoje.year, hoje.month, hoje.day);
    final dataLimpa = DateTime(data.year, data.month, data.day);
    return dataLimpa.difference(hojeLimpo).inDays;
  }

  void calcularMedia() {
    final n1 = double.tryParse(n1Controller.text.replaceAll(',', '.'));
    final n2 = double.tryParse(n2Controller.text.replaceAll(',', '.'));
    final n3 = double.tryParse(n3Controller.text.replaceAll(',', '.'));

    if (n1 == null || n2 == null || n3 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite as três notas para calcular.')),
      );
      return;
    }

    final resultado = (n1 + n2 + n3) / 3;

    setState(() {
      media = resultado;
      if (resultado >= 7) {
        situacao = 'Aprovado!';
      } else if (resultado >= 5) {
        situacao = 'Recuperação';
      } else {
        situacao = 'Reprovado';
      }
    });
  }

  void removerTarefa(int index) {
    setState(() {
      AppData.tarefas.removeAt(index);
    });
  }

  @override
  void dispose() {
    n1Controller.dispose();
    n2Controller.dispose();
    n3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tarefas = AppData.tarefas;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard EduCheck',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              abrirTela('/perfil');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          abrirTela('/nova-tarefa');
        },
        child: const Icon(Icons.add, size: 32),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 92),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Minhas Tarefas',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),

              if (tarefas.isEmpty)
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Text('Nenhuma tarefa cadastrada.'),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tarefas.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final tarefa = tarefas[index];
                    final dias = diasRestantes(tarefa.dataEntrega);
                    final textoPrazo = dias == 0
                        ? 'Entrega hoje'
                        : dias > 0
                            ? 'Em $dias dias'
                            : 'Atrasada há ${dias.abs()} dias';

                    return Dismissible(
                      key: ValueKey('${tarefa.titulo}-$index'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) => removerTarefa(index),
                      child: Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: AppColors.navy,
                            child: Icon(
                              tarefa.concluida ? Icons.check : Icons.book,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            tarefa.titulo,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                size: 16,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 4),
                              Text(textoPrazo),
                            ],
                          ),
                          trailing: Checkbox(
                            value: tarefa.concluida,
                            activeColor: AppColors.navy,
                            onChanged: (value) {
                              setState(() {
                                tarefa.concluida = value ?? false;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),

              const SizedBox(height: 22),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Calculadora de Médias',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: _notaField('N1', n1Controller)),
                          const SizedBox(width: 10),
                          Expanded(child: _notaField('N2', n2Controller)),
                          const SizedBox(width: 10),
                          Expanded(child: _notaField('N3', n3Controller)),
                        ],
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: calcularMedia,
                          child: const Text(
                            'Calcular Média',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      if (media != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9F7EF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFB8E0C2)),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.green,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Média: ${media!.toStringAsFixed(1)} - $situacao',
                                style: const TextStyle(
                                  color: AppColors.green,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => abrirTela('/disciplinas'),
                      icon: const Icon(Icons.menu_book),
                      label: const Text('Disciplinas'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => abrirTela('/calculadora'),
                      icon: const Icon(Icons.calculate),
                      label: const Text('Médias'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notaField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: label,
        prefixIcon: null,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}
