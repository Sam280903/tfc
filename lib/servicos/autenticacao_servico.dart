// lib/servicos/autenticacao_servico.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AutenticacaoServico {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> login(String email, String senha) async {
    try {
      final credenciais = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      return credenciais.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_traduzirErro(e.code));
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? get usuarioAtual => _auth.currentUser;

  String _traduzirErro(String code) {
    switch (code) {
      case 'user-not-found':
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Usuário ou senha incorretos.';
      case 'wrong-password':
        return 'Senha incorreta.';
      case 'invalid-email':
        return 'E-mail inválido.';
      default:
        return 'Erro ao fazer login. [$code]';
    }
  }

  Future<bool> primeiroGestorJaCadastrado() async {
    try {
      final doc =
          await _firestore.collection('configuracao').doc('sistema').get();
      if (doc.exists) {
        return doc.data()?['primeiroGestorCadastrado'] ?? false;
      }
      return false;
    } catch (e) {
      print("Erro ao verificar primeiro gestor: $e");
      return false;
    }
  }

  Future<User?> cadastrarPrimeiroGestor({
    required String nome,
    required String email,
    required String senha,
  }) async {
    try {
      final credenciais = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      final usuario = credenciais.user;

      if (usuario != null) {
        await _firestore.collection('usuarios').doc(usuario.uid).set({
          'nome': nome,
          'email': email,
          'perfil': 'gestor',
          'ativo': true,
        });

        await _firestore.collection('configuracao').doc('sistema').set({
          'primeiroGestorCadastrado': true,
        });
      }
      return usuario;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('Este e-mail já está em uso.');
      }
      if (e.code == 'weak-password') {
        throw Exception('A senha fornecida é muito fraca.');
      }
      throw Exception('Erro ao cadastrar: ${e.message}');
    }
  }

  // MÉTODO ADICIONADO: Busca os dados do utilizador logado no Firestore
  Future<Map<String, dynamic>?> buscarDadosUsuarioLogado() async {
    final usuario = _auth.currentUser; // Pega o utilizador atualmente logado
    if (usuario != null) {
      // Usa o UID para buscar o documento correspondente no Firestore
      final docSnapshot =
          await _firestore.collection('usuarios').doc(usuario.uid).get();
      if (docSnapshot.exists) {
        return docSnapshot.data(); // Retorna os dados: nome, email, perfil...
      }
    }
    return null;
  }
}
