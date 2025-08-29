// lib/dominio/interfaces/ordem_servico_repositorio_interface.dart

import '../entidades/ordem_servico.dart';

abstract class OrdemServicoRepositorioInterface {
  // Novo método para reabrir uma OS
  Future<void> reabrir({required String id, required String justificativa});

  Future<void> adicionar(OrdemServico ordem);
  Future<void> atualizar(OrdemServico ordem);
  Future<void> inativar(String id);
  Future<OrdemServico?> buscarPorId(String id);
  Future<List<OrdemServico>> listarTodos();
}
