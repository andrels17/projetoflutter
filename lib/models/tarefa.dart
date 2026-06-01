class Tarefa {
  String titulo;
  String disciplina;
  DateTime dataEntrega;
  bool concluida;

  Tarefa({
    required this.titulo,
    required this.disciplina,
    required this.dataEntrega,
    this.concluida = false,
  });
}
