import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  Map<String, String> toJson() {
    return {'nome': _nome};
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'dependentes': _dependentes.map((d) => d.toJson()).toList(),
    };
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  Map<String, dynamic> toJson() {
    return {
      'nomeProjeto': _nomeProjeto,
      'funcionarios': _funcionarios.map((f) => f.toJson()).toList(),
    };
  }
}

void main() {
  Dependente dep1 = Dependente('Johnny');
  Dependente dep2 = Dependente('Gorlack');
  Dependente dep3 = Dependente('Dana');

  Funcionario func1 = Funcionario('Carlos', [dep1, dep2]);
  Funcionario func2 = Funcionario('Roberta', [dep3]);

  List<Funcionario> funcionarios = [func1, func2];

  EquipeProjeto equipeProjeto = EquipeProjeto('ENEM', funcionarios);

  String jsonString = jsonEncode(equipeProjeto.toJson());
  print(const JsonEncoder.withIndent('  ').convert(equipeProjeto.toJson()));
}
