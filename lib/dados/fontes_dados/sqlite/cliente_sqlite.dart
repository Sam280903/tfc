import 'package:sqflite/sqflite.dart';
import 'package:gerenciar/dados/fontes_dados/sqlite/sqlite_conexao.dart';
import '../../modelos/cliente_model.dart';

class ClienteSQLite {
  Future<Database> get _db async => await SQLiteConexao.db;

  Future<void> adicionarCliente(ClienteModel cliente) async {
    final db = await _db;
    await db.insert(
      'clientes',
      cliente.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> atualizarCliente(ClienteModel cliente) async {
    final db = await _db;
    await db.update(
      'clientes',
      cliente.toMap(),
      where: 'id = ?',
      whereArgs: [cliente.id],
    );
  }

  Future<void> inativarCliente(String id) async {
    final db = await _db;
    await db.update(
      'clientes',
      {'ativo': false},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<ClienteModel?> buscarPorId(String id) async {
    final db = await _db;
    final resultado = await db.query(
      'clientes',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (resultado.isNotEmpty) {
      return ClienteModel.fromMap(
          resultado.first, resultado.first['id'] as String);
    }
    return null;
  }

  Future<List<ClienteModel>> listarTodos() async {
    final db = await _db;
    final resultado = await db.query(
      'clientes',
      where: 'ativo = ?',
      whereArgs: [1],
    );

    return resultado
        .map((row) => ClienteModel.fromMap(row, row['id'] as String))
        .toList();
  }
}
