// lib/dados/fontes_dados/firebase/ordem_servico_firebase.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../modelos/ordem_servico_model.dart';

class OrdemServicoFirebase {
  final _colecao = FirebaseFirestore.instance.collection('ordens_servico');

  // Novo método para reabrir
  Future<void> reabrir(
      {required String id, required String justificativa}) async {
    await _colecao.doc(id).update({
      'status': 'Reaberto',
      'justificativaReabertura': justificativa, // Campo para auditoria
      'dataReabertura': Timestamp.now(), // Campo para auditoria
    });
  }

  Future<void> adicionar(OrdemServicoModel os) async {
    // O método set sobrescreve o documento inteiro. Para adicionar, é melhor usar .add ou .doc(id).set
    await _colecao.doc(os.id).set(os.toMap());
  }

  Future<void> atualizar(OrdemServicoModel os) async {
    await _colecao.doc(os.id).update(os.toMap());
  }

  Future<void> inativar(String id) async {
    await _colecao.doc(id).update({'ativo': false});
  }

  Future<OrdemServicoModel?> buscarPorId(String id) async {
    final doc = await _colecao.doc(id).get();
    if (doc.exists && doc.data() != null) {
      return OrdemServicoModel.fromMap(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );
    }
    return null;
  }

  Future<List<OrdemServicoModel>> listarTodos() async {
    final snapshot = await _colecao.where('ativo', isEqualTo: true).get();
    return snapshot.docs.map((doc) {
      return OrdemServicoModel.fromMap(
        doc.data() as Map<String, dynamic>,
        doc.id,
      );
    }).toList();
  }
}
