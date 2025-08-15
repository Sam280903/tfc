import '../../dominio/entidades/cliente.dart';

class ClienteModel {
  final String id;
  final String nome;
  final String email;
  final String telefone;
  final String endereco;
  final bool ativo;

  ClienteModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.endereco,
    required this.ativo,
  });

  // 🔄 Converte de entidade para modelo
  factory ClienteModel.fromEntidade(Cliente cliente) {
    return ClienteModel(
      id: cliente.id,
      nome: cliente.nome,
      email: cliente.email,
      telefone: cliente.telefone,
      endereco: cliente.endereco,
      ativo: cliente.ativo,
    );
  }

  // 🔄 Converte de Map (Firebase ou SQLite) para modelo
  factory ClienteModel.fromMap(Map<String, dynamic> map, String id) {
    return ClienteModel(
      id: id,
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      telefone: map['telefone'] ?? '',
      endereco: map['endereco'] ?? '',
      ativo: map['ativo'] ?? true,
    );
  }

  // 🔄 Converte para Map (para salvar)
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
      'ativo': ativo,
    };
  }

  // 🔄 Converte para entidade
  Cliente toEntidade() {
    return Cliente(
      id: id,
      nome: nome,
      email: email,
      telefone: telefone,
      endereco: endereco,
      ativo: ativo,
    );
  }
}
