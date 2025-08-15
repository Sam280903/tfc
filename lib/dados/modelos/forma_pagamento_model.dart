import '../../dominio/entidades/forma_pagamento.dart';

class FormaPagamentoModel {
  final String id;
  final String nome;
  final String? descricao;
  final bool ativo;

  FormaPagamentoModel({
    required this.id,
    required this.nome,
    this.descricao,
    required this.ativo,
  });

  // 🔁 Converte de entidade para modelo
  factory FormaPagamentoModel.fromEntidade(FormaPagamento entidade) {
    return FormaPagamentoModel(
      id: entidade.id,
      nome: entidade.nome,
      descricao: entidade.descricao,
      ativo: entidade.ativo,
    );
  }

  // 🔁 Converte de Map para modelo
  factory FormaPagamentoModel.fromMap(Map<String, dynamic> map, String id) {
    return FormaPagamentoModel(
      id: id,
      nome: map['nome'] ?? '',
      descricao: map['descricao'],
      ativo: map['ativo'] ?? true,
    );
  }

  // 🔁 Converte para Map
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'descricao': descricao,
      'ativo': ativo,
    };
  }

  // 🔁 Converte para entidade
  FormaPagamento toEntidade() {
    return FormaPagamento(
      id: id,
      nome: nome,
      descricao: descricao,
      ativo: ativo,
    );
  }
}
