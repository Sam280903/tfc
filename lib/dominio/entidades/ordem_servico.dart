class OrdemServico {
  final String id;
  final String idTecnico;
  final String idCliente;
  final DateTime dataHoraInicio;
  final DateTime? dataHoraFim;
  final String descricao;
  final double valor;
  final String status; // Ex: "pendente", "em andamento", "finalizada"
  final bool ativo;

  OrdemServico({
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
}
