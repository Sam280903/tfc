import 'package:sqflite/sqflite.dart';
import 'package:gerenciar/dados/fontes_dados/sqlite/sqlite_conexao.dart';
import '../../modelos/forma_pagamento_model.dart';

class FormaPagamentoSQLite {
  Future<Database> get _db async => await SQLiteConexao.db;

  Future<void> adicionar(FormaPagamentoModel forma) async {
    final db = await _db;
    await db.insert(
      'formas_pagamento',
      forma.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> atualizar(FormaPagamentoModel forma) async {
    final db = await _db;
    await db.update(
      'formas_pagamento',
      forma.toMap(),
      where: 'id = ?',
      whereArgs: [forma.id],
    );
  }

  Future<void> inativar(String id) async {
    final db = await _db;
    await db.update(
      'formas_pagamento',
      {'ativo': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<FormaPagamentoModel?> buscarPorId(String id) async {
    final db = await _db;
    final resultado = await db.query(
      'formas_pagamento',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (resultado.isNotEmpty) {
      return FormaPagamentoModel.fromMap(
        resultado.first,
        resultado.first['id'] as String,
      );
    }
    return null;
  }

  Future<List<FormaPagamentoModel>> listarTodos() async {
    final db = await _db;
    final resultado = await db.query(
      'formas_pagamento',
      where: 'ativo = ?',
      whereArgs: [1],
    );
    return resultado.map((row) {
      return FormaPagamentoModel.fromMap(
        row,
        row['id'] as String,
      );
    }).toList();
  }
}
