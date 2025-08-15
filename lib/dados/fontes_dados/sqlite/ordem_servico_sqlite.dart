import 'package:sqflite/sqflite.dart';
import 'package:gerenciar/dados/fontes_dados/sqlite/sqlite_conexao.dart';
import '../../modelos/ordem_servico_model.dart';

class OrdemServicoSQLite {
  Future<Database> get _db async => await SQLiteConexao.db;

  Future<void> adicionar(OrdemServicoModel os) async {
    final db = await _db;
    await db.insert(
      'ordens_servico',
      os.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> atualizar(OrdemServicoModel os) async {
    final db = await _db;
    await db.update(
      'ordens_servico',
      os.toMap(),
      where: 'id = ?',
      whereArgs: [os.id],
    );
  }

  Future<void> inativar(String id) async {
    final db = await _db;
    await db.update(
      'ordens_servico',
      {'ativo': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<OrdemServicoModel?> buscarPorId(String id) async {
    final db = await _db;
    final resultado = await db.query(
      'ordens_servico',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (resultado.isNotEmpty) {
      return OrdemServicoModel.fromMap(
        resultado.first,
        resultado.first['id'] as String,
      );
    }
    return null;
  }

  Future<List<OrdemServicoModel>> listarTodos() async {
    final db = await _db;
    final resultado = await db.query(
      'ordens_servico',
      where: 'ativo = ?',
      whereArgs: [1],
    );
    return resultado.map((linha) {
      return OrdemServicoModel.fromMap(
        linha,
        linha['id'] as String,
      );
    }).toList();
  }
}
