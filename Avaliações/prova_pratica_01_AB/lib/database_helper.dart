import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'aluno.dart'; // Importando a classe Aluno

// Função para obter o caminho do banco de dados
Future<Database> getDatabase() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = join(directory.path, 'alunos.db');

  return openDatabase(path, version: 1, onCreate: (db, version) async {
    await db.execute('''
      CREATE TABLE TB_ALUNOS(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        idade INTEGER
      )
    ''');
  });
}

// Função para inserir um novo aluno
Future<void> inserirAluno(Aluno aluno) async {
  final db = await getDatabase();
  await db.insert(
    'TB_ALUNOS',
    aluno.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

// Função para consultar todos os alunos
Future<List<Aluno>> consultarAlunos() async {
  final db = await getDatabase();
  final List<Map<String, dynamic>> maps = await db.query('TB_ALUNOS');

  return List.generate(maps.length, (i) {
    return Aluno.fromMap(maps[i]);
  });
}

// Função para atualizar um aluno
Future<void> atualizarAluno(Aluno aluno) async {
  final db = await getDatabase();
  await db.update(
    'TB_ALUNOS',
    aluno.toMap(),
    where: 'id = ?',
    whereArgs: [aluno.id],
  );
}

// Função para excluir um aluno
Future<void> excluirAluno(int id) async {
  final db = await getDatabase();
  await db.delete(
    'TB_ALUNOS',
    where: 'id = ?',
    whereArgs: [id],
  );
}
