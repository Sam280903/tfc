import '../entidades/agendamento.dart';

abstract class AgendamentoRepositorioInterface {
  Future<void> adicionar(Agendamento agendamento);
  Future<void> atualizar(Agendamento agendamento);
  Future<void> inativar(String id);
  Future<Agendamento?> buscarPorId(String id);
  Future<List<Agendamento>> listarTodos();
}
