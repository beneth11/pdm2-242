// Benete Zabdiel Cassiano Silva

import 'package:flutter/material.dart';
import 'aluno.dart';
import 'database_helper.dart'; // Importando as funções do banco de dados

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciamento de Alunos', // Título do app
      theme: ThemeData(
        primarySwatch: Colors.blue, // Cor do tema
      ),
      home: AlunoPage(),
    );
  }
}

class AlunoPage extends StatefulWidget {
  @override
  _AlunoPageState createState() => _AlunoPageState();
}

class _AlunoPageState extends State<AlunoPage> {
  final List<Aluno> alunos = [];

  @override
  void initState() {
    super.initState();
    _carregarAlunos();
  }

  Future<void> _carregarAlunos() async {
    // Função que carrega os alunos do banco de dados
    final List<Aluno> alunosCarregados = await consultarAlunos();
    setState(() {
      alunos.clear();
      alunos.addAll(alunosCarregados);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciamento de Alunos'),
      ),
      body: ListView.builder(
        itemCount: alunos.length,
        itemBuilder: (context, index) {
          final aluno = alunos[index];
          return ListTile(
            title: Text(aluno.nome),
            subtitle: Text('Idade: ${aluno.idade}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    // Exemplo de atualização: Atualiza a idade
                    aluno.idade += 1;
                    await atualizarAluno(aluno);
                    _carregarAlunos(); // Recarregar a lista
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    // Excluir aluno
                    await excluirAluno(aluno.id!);
                    _carregarAlunos(); // Recarregar a lista
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Exemplo de inserção de aluno
          final novoAluno = Aluno(nome: 'Novo Aluno', idade: 20);
          await inserirAluno(novoAluno);
          _carregarAlunos(); // Recarregar a lista
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
