// Benete Zabdiel Cassiano Silva


class Aluno {
  int? id;
  String nome;
  int idade;

  Aluno({this.id, required this.nome, required this.idade});

  // Construtor que converte um Map para um Aluno
  factory Aluno.fromMap(Map<String, dynamic> map) {
    return Aluno(
      id: map['id'],
      nome: map['nome'],
      idade: map['idade'],
    );
  }

  // Construtor que converte um Aluno para um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
    };
  }
}
