import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:gerenciar/dominio/entidades/agendamento.dart';
import 'package:gerenciar/dominio/interfaces/agendamento_repositorio_interface.dart';
import 'agendamento_repositorio_impl.dart';
import 'agendamento_repositorio_impl_sqlite.dart';

class AgendamentoRepositorioAdaptativo
    implements AgendamentoRepositorioInterface {
  final _firebase = AgendamentoRepositorioImpl();
  final _sqlite = AgendamentoRepositorioImplSQLite();

  Future<bool> _temConexao() async {
    final status = await Connectivity().checkConnectivity();
    return status != ConnectivityResult.none;
  }

  Future<AgendamentoRepositorioInterface> _escolherRepositorio() async {
    return await _temConexao() ? _firebase : _sqlite;
  }

  @override
  Future<void> adicionar(Agendamento agendamento) async {
    final repo = await _escolherRepositorio();
    await repo.adicionar(agendamento);
  }

  @override
  Future<void> atualizar(Agendamento agendamento) async {
    final repo = await _escolherRepositorio();
    await repo.atualizar(agendamento);
  }

  @override
  Future<void> inativar(String id) async {
    final repo = await _escolherRepositorio();
    await repo.inativar(id);
  }

  @override
  Future<Agendamento?> buscarPorId(String id) async {
    final repo = await _escolherRepositorio();
    return await repo.buscarPorId(id);
  }

  @override
  Future<List<Agendamento>> listarTodos() async {
    final repo = await _escolherRepositorio();
    return await repo.listarTodos();
  }
}
