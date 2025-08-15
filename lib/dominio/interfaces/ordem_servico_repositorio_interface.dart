import '../entidades/ordem_servico.dart';

abstract class OrdemServicoRepositorioInterface {
  Future<void> adicionar(OrdemServico ordem);
  Future<void> atualizar(OrdemServico ordem);
  Future<void> inativar(String id);
  Future<OrdemServico?> buscarPorId(String id);
  Future<List<OrdemServico>> listarTodos();
}
