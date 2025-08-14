import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoHelper {
  static final BancoHelper _instancia = BancoHelper._();
  static Database? _banco;

  BancoHelper._();

  factory BancoHelper() => _instancia;

  Future<Database> get banco async {
    if (_banco != null) return _banco!;
    _banco = await _inicializarBanco();
    return _banco!;
  }

  Future<Database> _inicializarBanco() async {
    final caminhoBanco = await getDatabasesPath();
    final caminho = join(caminhoBanco, 'gerenciar.db');

    return await openDatabase(
      caminho,
      version: 1,
      onCreate: (db, versao) async {
        await db.execute('''
          CREATE TABLE tecnicos (
            id TEXT PRIMARY KEY,
            nome TEXT,
            email TEXT,
            telefone TEXT,
            ativo INTEGER
          )
        ''');
      },
    );
  }
}
