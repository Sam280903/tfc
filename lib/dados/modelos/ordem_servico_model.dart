import '../../dominio/entidades/ordem_servico.dart';

class OrdemServicoModel {
  final String id;
  final String idTecnico;
  final String idCliente;
  final DateTime dataHoraInicio;
  final DateTime? dataHoraFim;
  final String descricao;
  final double valor;
  final String status;
  final bool ativo;

  OrdemServicoModel({
    required this.id,
    required this.idTecnico,
    required this.idCliente,
    required this.dataHoraInicio,
    this.dataHoraFim,
    required this.descricao,
    required this.valor,
    required this.status,
    required this.ativo,
  });

  factory OrdemServicoModel.fromEntidade(OrdemServico os) {
    return OrdemServicoModel(
      id: os.id,
      idTecnico: os.idTecnico,
      idCliente: os.idCliente,
      dataHoraInicio: os.dataHoraInicio,
      dataHoraFim: os.dataHoraFim,
      descricao: os.descricao,
      valor: os.valor,
      status: os.status,
      ativo: os.ativo,
    );
  }

  factory OrdemServicoModel.fromMap(Map<String, dynamic> map, String id) {
    return OrdemServicoModel(
      id: id,
      idTecnico: map['idTecnico'],
      idCliente: map['idCliente'],
      dataHoraInicio: DateTime.parse(map['dataHoraInicio']),
      dataHoraFim: map['dataHoraFim'] != null
          ? DateTime.tryParse(map['dataHoraFim'])
          : null,
      descricao: map['descricao'],
      valor: map['valor']?.toDouble() ?? 0.0,
      status: map['status'],
      ativo: map['ativo'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idTecnico': idTecnico,
      'idCliente': idCliente,
      'dataHoraInicio': dataHoraInicio.toIso8601String(),
      'dataHoraFim': dataHoraFim?.toIso8601String(),
      'descricao': descricao,
      'valor': valor,
      'status': status,
      'ativo': ativo,
    };
  }

  OrdemServico toEntidade() {
    return OrdemServico(
      id: id,
      idTecnico: idTecnico,
      idCliente: idCliente,
      dataHoraInicio: dataHoraInicio,
      dataHoraFim: dataHoraFim,
      descricao: descricao,
      valor: valor,
      status: status,
      ativo: ativo,
    );
  }
}
