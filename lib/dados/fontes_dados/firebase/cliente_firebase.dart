import 'package:cloud_firestore/cloud_firestore.dart';
import '../../modelos/cliente_model.dart';

class ClienteFirebase {
  final CollectionReference _colecao =
      FirebaseFirestore.instance.collection('clientes');

  Future<void> adicionarCliente(ClienteModel cliente) async {
    await _colecao.doc(cliente.id).set(cliente.toMap());
  }

  Future<void> atualizarCliente(ClienteModel cliente) async {
    await _colecao.doc(cliente.id).update(cliente.toMap());
  }

  Future<void> inativarCliente(String id) async {
    await _colecao.doc(id).update({'ativo': false});
  }

  Future<ClienteModel?> buscarPorId(String id) async {
    final doc = await _colecao.doc(id).get();
    if (doc.exists && doc.data() != null) {
      return ClienteModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Future<List<ClienteModel>> listarTodos() async {
    final snapshot = await _colecao.where('ativo', isEqualTo: true).get();
    return snapshot.docs
        .map((doc) =>
            ClienteModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}
