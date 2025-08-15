import '../../entidades/forma_pagamento.dart';
import '../../interfaces/forma_pagamento_repositorio_interface.dart';

class AtualizarFormaPagamento {
  final FormaPagamentoRepositorioInterface repositorio;

  AtualizarFormaPagamento(this.repositorio);

  Future<void> executar(FormaPagamento forma) async {
    await repositorio.atualizar(forma);
  }
}
