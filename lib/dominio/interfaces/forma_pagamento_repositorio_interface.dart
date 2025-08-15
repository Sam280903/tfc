import '../entidades/forma_pagamento.dart';

abstract class FormaPagamentoRepositorioInterface {
  Future<void> adicionar(FormaPagamento forma);
  Future<void> atualizar(FormaPagamento forma);
  Future<void> inativar(String id);
  Future<FormaPagamento?> buscarPorId(String id);
  Future<List<FormaPagamento>> listarTodos();
}
