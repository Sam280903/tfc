import '../../entidades/agendamento.dart';
import '../../interfaces/agendamento_repositorio_interface.dart';

class CadastrarAgendamento {
  final AgendamentoRepositorioInterface repositorio;

  CadastrarAgendamento(this.repositorio);

  Future<void> executar(Agendamento agendamento) async {
    await repositorio.adicionar(agendamento);
  }
}
