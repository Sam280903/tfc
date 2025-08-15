import 'package:gerenciar/dominio/interfaces/tecnico_repositorio_interface.dart';
import 'package:gerenciar/dominio/entidades/tecnico.dart';
import '../../modelos/tecnico_model.dart';
import '../../fontes_dados/sqlite/tecnico_sqlite.dart';

class TecnicoRepositorioImplSQLite implements TecnicoRepositorioInterface {
  final TecnicoSQLite _fonteSQLite = TecnicoSQLite();

  @override
  Future<void> adicionar(Tecnico tecnico) async {
    final model = TecnicoModel(
      id: tecnico.id,
      nome: tecnico.nome,
      email: tecnico.email,
      telefone: tecnico.telefone,
      ativo: tecnico.ativo,
    );
    await _fonteSQLite.adicionarTecnico(model);
  }

  @override
  Future<void> atualizar(Tecnico tecnico) async {
    final model = TecnicoModel(
      id: tecnico.id,
      nome: tecnico.nome,
      email: tecnico.email,
      telefone: tecnico.telefone,
      ativo: tecnico.ativo,
    );
    await _fonteSQLite.atualizarTecnico(model);
  }

  @override
  Future<void> inativar(String id) async {
    await _fonteSQLite.inativarTecnico(id);
  }

  @override
  Future<Tecnico?> buscarPorId(String id) async {
    final model = await _fonteSQLite.buscarPorId(id);
    if (model == null) return null;

    return Tecnico(
      id: model.id,
      nome: model.nome,
      email: model.email,
      telefone: model.telefone,
      ativo: model.ativo,
    );
  }

  @override
  Future<List<Tecnico>> listarTodos() async {
    final modelos = await _fonteSQLite.listarTodos();
    return modelos
        .map((m) => Tecnico(
              id: m.id,
              nome: m.nome,
              email: m.email,
              telefone: m.telefone,
              ativo: m.ativo,
            ))
        .toList();
  }
}
