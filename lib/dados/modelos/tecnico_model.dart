class TecnicoModel {
  final String id;
  final String nome;
  final String email;
  final String telefone;
  final bool ativo;

  TecnicoModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.ativo,
  });

  factory TecnicoModel.fromMap(Map<String, dynamic> map, String id) {
    return TecnicoModel(
      id: id,
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      telefone: map['telefone'] ?? '',
      ativo: map['ativo'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'ativo': ativo,
    };
  }
}
