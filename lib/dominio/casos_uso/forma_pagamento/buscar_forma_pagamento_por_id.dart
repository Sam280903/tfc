import '../../entidades/forma_pagamento.dart';
import '../../interfaces/forma_pagamento_repositorio_interface.dart';

class BuscarFormaPagamentoPorId {
  final FormaPagamentoRepositorioInterface repositorio;

  BuscarFormaPagamentoPorId(this.repositorio);

  Future<FormaPagamento?> executar(String id) async {
    return await repositorio.buscarPorId(id);
  }
}
