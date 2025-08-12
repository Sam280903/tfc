import '../entidades/tecnico.dart';

abstract class TecnicoRepositorioInterface {
  Future<void> adicionar(Tecnico tecnico);
  Future<void> atualizar(Tecnico tecnico);
  Future<void> inativar(String id);
  Future<Tecnico?> buscarPorId(String id);
  Future<List<Tecnico>> listarTodos();
}
