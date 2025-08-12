import 'package:sqflite/sqflite.dart';
import 'banco_helper.dart';
import '../../modelos/tecnico_model.dart';

class TecnicoSQLite {
  Future<void> adicionarTecnico(TecnicoModel tecnico) async {
    final db = await BancoHelper().banco;
    await db.insert(
      'tecnicos',
      tecnico.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> atualizarTecnico(TecnicoModel tecnico) async {
    final db = await BancoHelper().banco;
    await db.update(
      'tecnicos',
      tecnico.toMap(),
      where: 'id = ?',
      whereArgs: [tecnico.id],
    );
  }

  Future<void> inativarTecnico(String id) async {
    final db = await BancoHelper().banco;
    await db.update(
      'tecnicos',
      {'ativo': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<TecnicoModel?> buscarPorId(String id) async {
    final db = await BancoHelper().banco;
    final resultado = await db.query(
      'tecnicos',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (resultado.isNotEmpty) {
      return TecnicoModel.fromMap(
          resultado.first, resultado.first['id'] as String);
    }
    return null;
  }

  Future<List<TecnicoModel>> listarTodos() async {
    final db = await BancoHelper().banco;
    final resultado = await db.query(
      'tecnicos',
      where: 'ativo = ?',
      whereArgs: [1],
    );
    return resultado.map((linha) {
      return TecnicoModel.fromMap(linha, linha['id'] as String);
    }).toList();
  }
}
