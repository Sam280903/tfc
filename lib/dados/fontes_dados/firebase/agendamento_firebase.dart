import 'package:cloud_firestore/cloud_firestore.dart';
import '../../modelos/agendamento_model.dart';

class AgendamentoFirebase {
  final _colecao = FirebaseFirestore.instance.collection('agendamentos');

  Future<void> adicionar(AgendamentoModel agendamento) async {
    await _colecao.doc(agendamento.id).set(agendamento.toMap());
  }

  Future<void> atualizar(AgendamentoModel agendamento) async {
    await _colecao.doc(agendamento.id).update(agendamento.toMap());
  }

  Future<void> inativar(String id) async {
    await _colecao.doc(id).update({'ativo': false});
  }

  Future<AgendamentoModel?> buscarPorId(String id) async {
    final doc = await _colecao.doc(id).get();
    if (doc.exists && doc.data() != null) {
      return AgendamentoModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Future<List<AgendamentoModel>> listarTodos() async {
    final snapshot = await _colecao.where('ativo', isEqualTo: true).get();
    return snapshot.docs.map((doc) {
      return AgendamentoModel.fromMap(doc.data(), doc.id);
    }).toList();
  }
}
