import 'package:gerenciar/dominio/entidades/agendamento.dart';
import 'package:gerenciar/dominio/interfaces/agendamento_repositorio_interface.dart';
import '../../fontes_dados/sqlite/agendamento_sqlite.dart';
import '../../modelos/agendamento_model.dart';

class AgendamentoRepositorioImplSQLite
    implements AgendamentoRepositorioInterface {
  final AgendamentoSQLite _sqlite = AgendamentoSQLite();

  @override
  Future<void> adicionar(Agendamento agendamento) async {
    final model = AgendamentoModel.fromEntidade(agendamento);
    await _sqlite.adicionar(model);
  }

  @override
  Future<void> atualizar(Agendamento agendamento) async {
    final model = AgendamentoModel.fromEntidade(agendamento);
    await _sqlite.atualizar(model);
  }

  @override
  Future<void> inativar(String id) async {
    await _sqlite.inativar(id);
  }

  @override
  Future<Agendamento?> buscarPorId(String id) async {
    final model = await _sqlite.buscarPorId(id);
    return model?.toEntidade();
  }

  @override
  Future<List<Agendamento>> listarTodos() async {
    final modelos = await _sqlite.listarTodos();
    return modelos.map((m) => m.toEntidade()).toList();
  }
}
