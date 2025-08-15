import '../../entidades/forma_pagamento.dart';
import '../../interfaces/forma_pagamento_repositorio_interface.dart';

class CadastrarFormaPagamento {
  final FormaPagamentoRepositorioInterface repositorio;

  CadastrarFormaPagamento(this.repositorio);

  Future<void> executar(FormaPagamento forma) async {
    await repositorio.adicionar(forma);
  }
}
