import 'package:cloud_firestore/cloud_firestore.dart';
import '../../modelos/forma_pagamento_model.dart';

class FormaPagamentoFirebase {
  final CollectionReference _colecao =
      FirebaseFirestore.instance.collection('formas_pagamento');

  Future<void> adicionar(FormaPagamentoModel forma) async {
    await _colecao.doc(forma.id).set(forma.toMap());
  }

  Future<void> atualizar(FormaPagamentoModel forma) async {
    await _colecao.doc(forma.id).update(forma.toMap());
  }

  Future<void> inativar(String id) async {
    await _colecao.doc(id).update({'ativo': false});
  }

  Future<FormaPagamentoModel?> buscarPorId(String id) async {
    final doc = await _colecao.doc(id).get();
    if (doc.exists && doc.data() != null) {
      return FormaPagamentoModel.fromMap(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );
    }
    return null;
  }

  Future<List<FormaPagamentoModel>> listarTodos() async {
    final snapshot = await _colecao.where('ativo', isEqualTo: true).get();
    return snapshot.docs
        .map((doc) => FormaPagamentoModel.fromMap(
              doc.data() as Map<String, dynamic>,
              doc.id,
            ))
        .toList();
  }
}
