// lib/dados/modelos/ordem_servico_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
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

  // Construtor para dados vindos do Firebase
  factory OrdemServicoModel.fromMap(Map<String, dynamic> map, String id) {
    return OrdemServicoModel(
      id: id,
      idTecnico: map['idTecnico'],
      idCliente: map['idCliente'],
      // O Firebase usa Timestamps, então precisamos convertê-los.
      dataHoraInicio: (map['dataHoraInicio'] as Timestamp).toDate(),
      dataHoraFim: map['dataHoraFim'] != null
          ? (map['dataHoraFim'] as Timestamp).toDate()
          : null,
      descricao: map['descricao'],
      valor: (map['valor'] ?? 0.0).toDouble(),
      status: map['status'],
      ativo: map['ativo'] ?? true,
    );
  }

  // NOVO CONSTRUTOR: Para dados vindos do SQLite
  factory OrdemServicoModel.fromDbMap(Map<String, dynamic> map) {
    return OrdemServicoModel(
      id: map['id'],
      idTecnico: map['idTecnico'],
      idCliente: map['idCliente'],
      // O SQLite usa Strings para datas, então precisamos convertê-las.
      dataHoraInicio: DateTime.parse(map['dataHoraInicio']),
      dataHoraFim: map['dataHoraFim'] != null
          ? DateTime.parse(map['dataHoraFim'])
          : null,
      descricao: map['descricao'],
      valor: map['valor'],
      status: map['status'],
      // O SQLite usa inteiros (0 ou 1) para booleanos.
      ativo: map['ativo'] == 1,
    );
  }

  // Método para salvar no Firebase
  Map<String, dynamic> toMap() {
    return {
      'idTecnico': idTecnico,
      'idCliente': idCliente,
      'dataHoraInicio': Timestamp.fromDate(dataHoraInicio),
      'dataHoraFim':
          dataHoraFim != null ? Timestamp.fromDate(dataHoraFim!) : null,
      'descricao': descricao,
      'valor': valor,
      'status': status,
      'ativo': ativo,
    };
  }

  // NOVO MÉTODO: Para salvar no SQLite
  Map<String, dynamic> toMapForDb() {
    return {
      'id': id,
      'idTecnico': idTecnico,
      'idCliente': idCliente,
      'dataHoraInicio': dataHoraInicio.toIso8601String(),
      'dataHoraFim': dataHoraFim?.toIso8601String(),
      'descricao': descricao,
      'valor': valor,
      'status': status,
      'ativo': ativo ? 1 : 0,
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
