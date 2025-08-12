import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gerenciar/dados/modelos/tecnico_model.dart';

class TecnicoFirebase {
  final _colecao = FirebaseFirestore.instance.collection('tecnicos');

  Future<void> adicionarTecnico(TecnicoModel tecnico) async {
    await _colecao.doc(tecnico.id).set(tecnico.toMap());
  }

  Future<void> atualizarTecnico(TecnicoModel tecnico) async {
    await _colecao.doc(tecnico.id).update(tecnico.toMap());
  }

  Future<void> inativarTecnico(String id) async {
    await _colecao.doc(id).update({'ativo': false});
  }

  Future<TecnicoModel?> buscarPorId(String id) async {
    final doc = await _colecao.doc(id).get();
    if (doc.exists && doc.data() != null) {
      return TecnicoModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Future<List<TecnicoModel>> listarTodos() async {
    final query = await _colecao.where('ativo', isEqualTo: true).get();
    return query.docs
        .map((doc) => TecnicoModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}
