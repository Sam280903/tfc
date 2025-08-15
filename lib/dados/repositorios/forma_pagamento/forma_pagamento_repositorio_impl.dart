import 'package:gerenciar/dominio/entidades/forma_pagamento.dart';
import 'package:gerenciar/dominio/interfaces/forma_pagamento_repositorio_interface.dart';
import '../../fontes_dados/firebase/forma_pagamento_firebase.dart';
import '../../modelos/forma_pagamento_model.dart';

class FormaPagamentoRepositorioImpl
    implements FormaPagamentoRepositorioInterface {
  final FormaPagamentoFirebase _fonteFirebase = FormaPagamentoFirebase();

  @override
  Future<void> adicionar(FormaPagamento forma) async {
    final model = FormaPagamentoModel.fromEntidade(forma);
    await _fonteFirebase.adicionar(model);
  }

  @override
  Future<void> atualizar(FormaPagamento forma) async {
    final model = FormaPagamentoModel.fromEntidade(forma);
    await _fonteFirebase.atualizar(model);
  }

  @override
  Future<void> inativar(String id) async {
    await _fonteFirebase.inativar(id);
  }

  @override
  Future<FormaPagamento?> buscarPorId(String id) async {
    final model = await _fonteFirebase.buscarPorId(id);
    return model?.toEntidade();
  }

  @override
  Future<List<FormaPagamento>> listarTodos() async {
    final modelos = await _fonteFirebase.listarTodos();
    return modelos.map((m) => m.toEntidade()).toList();
  }
}
