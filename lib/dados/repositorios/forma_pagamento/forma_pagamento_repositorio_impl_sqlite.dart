import 'package:gerenciar/dominio/entidades/forma_pagamento.dart';
import 'package:gerenciar/dominio/interfaces/forma_pagamento_repositorio_interface.dart';
import '../../fontes_dados/sqlite/forma_pagamento_sqlite.dart';
import '../../modelos/forma_pagamento_model.dart';

class FormaPagamentoRepositorioImplSQLite
    implements FormaPagamentoRepositorioInterface {
  final FormaPagamentoSQLite _fonteSQLite = FormaPagamentoSQLite();

  @override
  Future<void> adicionar(FormaPagamento forma) async {
    final model = FormaPagamentoModel.fromEntidade(forma);
    await _fonteSQLite.adicionar(model);
  }

  @override
  Future<void> atualizar(FormaPagamento forma) async {
    final model = FormaPagamentoModel.fromEntidade(forma);
    await _fonteSQLite.atualizar(model);
  }

  @override
  Future<void> inativar(String id) async {
    await _fonteSQLite.inativar(id);
  }

  @override
  Future<FormaPagamento?> buscarPorId(String id) async {
    final model = await _fonteSQLite.buscarPorId(id);
    return model?.toEntidade();
  }

  @override
  Future<List<FormaPagamento>> listarTodos() async {
    final modelos = await _fonteSQLite.listarTodos();
    return modelos.map((m) => m.toEntidade()).toList();
  }
}
