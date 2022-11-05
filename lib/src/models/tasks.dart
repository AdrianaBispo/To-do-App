class Task {
  String tarefa;
  String descricao;
  Task({
    required this.tarefa,
    required this.descricao,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      tarefa: json['tarefa'],
      descricao: json['descricao'],
    );
  }
  Map<String, dynamic> toJson() => {
    'tarefa': tarefa,
    'descricao': descricao,
  };
}
