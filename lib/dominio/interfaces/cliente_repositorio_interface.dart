import '../entidades/cliente.dart';

abstract class ClienteRepositorioInterface {
  Future<void> adicionar(Cliente cliente);
  Future<void> atualizar(Cliente cliente);
  Future<void> inativar(String id);
  Future<Cliente?> buscarPorId(String id);
  Future<List<Cliente>> listarTodos();
}
