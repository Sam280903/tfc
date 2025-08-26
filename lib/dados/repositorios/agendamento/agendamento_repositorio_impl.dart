import 'package:gerenciar/dominio/entidades/agendamento.dart';
import 'package:gerenciar/dominio/interfaces/agendamento_repositorio_interface.dart';
import '../../fontes_dados/firebase/agendamento_firebase.dart';
import '../../modelos/agendamento_model.dart';

class AgendamentoRepositorioImpl implements AgendamentoRepositorioInterface {
  final AgendamentoFirebase _firebase = AgendamentoFirebase();

  @override
  Future<void> adicionar(Agendamento agendamento) async {
    final model = AgendamentoModel.fromEntidade(agendamento);
    await _firebase.adicionar(model);
  }

  @override
  Future<void> atualizar(Agendamento agendamento) async {
    final model = AgendamentoModel.fromEntidade(agendamento);
    await _firebase.atualizar(model);
  }

  @override
  Future<void> inativar(String id) async {
    await _firebase.inativar(id);
  }

  @override
  Future<Agendamento?> buscarPorId(String id) async {
    final model = await _firebase.buscarPorId(id);
    return model?.toEntidade();
  }

  @override
  Future<List<Agendamento>> listarTodos() async {
    final modelos = await _firebase.listarTodos();
    return modelos.map((m) => m.toEntidade()).toList();
  }
}
