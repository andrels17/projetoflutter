import '../models/tarefa.dart';
import '../models/disciplina.dart';

class AppData {
  static String nomeUsuario = 'Estudante';
  static String emailUsuario = 'estudante@email.com';

  static List<Tarefa> tarefas = [
    Tarefa(
      titulo: 'Entrega do Projeto de Mobile',
      disciplina: 'Desenvolvimento Mobile',
      dataEntrega: DateTime.now().add(const Duration(days: 2)),
    ),
    Tarefa(
      titulo: 'Estudar para Prova de Álgebra',
      disciplina: 'Matemática',
      dataEntrega: DateTime.now().add(const Duration(days: 5)),
    ),
  ];

  static List<Disciplina> disciplinas = [
    Disciplina(
      nome: 'Desenvolvimento Mobile',
      professor: 'Professor(a)',
      horario: 'Segunda e Quarta - 08:00',
    ),
  ];
}
