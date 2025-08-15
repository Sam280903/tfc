import '../../entidades/forma_pagamento.dart';
import '../../interfaces/forma_pagamento_repositorio_interface.dart';

class ListarFormasPagamento {
  final FormaPagamentoRepositorioInterface repositorio;

  ListarFormasPagamento(this.repositorio);

  Future<List<FormaPagamento>> executar() async {
    return await repositorio.listarTodos();
  }
}
