import '../../interfaces/forma_pagamento_repositorio_interface.dart';

class InativarFormaPagamento {
  final FormaPagamentoRepositorioInterface repositorio;

  InativarFormaPagamento(this.repositorio);

  Future<void> executar(String id) async {
    await repositorio.inativar(id);
  }
}
