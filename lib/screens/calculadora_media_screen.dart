import 'package:flutter/material.dart';

class CalculadoraMediaScreen extends StatefulWidget {
  const CalculadoraMediaScreen({super.key});

  @override
  State<CalculadoraMediaScreen> createState() => _CalculadoraMediaScreenState();
}

class _CalculadoraMediaScreenState extends State<CalculadoraMediaScreen> {
  final TextEditingController nota1Controller = TextEditingController();
  final TextEditingController nota2Controller = TextEditingController();
  final TextEditingController nota3Controller = TextEditingController();

  double? media;
  String situacao = '';

  void calcularMedia() {
    final nota1 = double.tryParse(nota1Controller.text.replaceAll(',', '.'));
    final nota2 = double.tryParse(nota2Controller.text.replaceAll(',', '.'));
    final nota3 = double.tryParse(nota3Controller.text.replaceAll(',', '.'));

    if (nota1 == null || nota2 == null || nota3 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite notas válidas.'),
        ),
      );
      return;
    }

    final resultado = (nota1 + nota2 + nota3) / 3;

    setState(() {
      media = resultado;

      if (resultado >= 7) {
        situacao = 'Aprovado';
      } else if (resultado >= 5) {
        situacao = 'Recuperação';
      } else {
        situacao = 'Reprovado';
      }
    });
  }

  void limpar() {
    setState(() {
      nota1Controller.clear();
      nota2Controller.clear();
      nota3Controller.clear();
      media = null;
      situacao = '';
    });
  }

  @override
  void dispose() {
    nota1Controller.dispose();
    nota2Controller.dispose();
    nota3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color corSituacao = Colors.grey;

    if (situacao == 'Aprovado') {
      corSituacao = Colors.green;
    } else if (situacao == 'Recuperação') {
      corSituacao = Colors.orange;
    } else if (situacao == 'Reprovado') {
      corSituacao = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Médias'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Icon(
                  Icons.calculate,
                  size: 70,
                  color: Colors.indigo,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Calcule sua média acadêmica',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nota1Controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Nota 1',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: nota2Controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Nota 2',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: nota3Controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Nota 3',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: calcularMedia,
                        icon: const Icon(Icons.check),
                        label: const Text('Calcular'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: limpar,
                        icon: const Icon(Icons.cleaning_services),
                        label: const Text('Limpar'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (media != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: corSituacao.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: corSituacao),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Média: ${media!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Situação: $situacao',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: corSituacao,
                          ),
                        ),
                      ],
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
