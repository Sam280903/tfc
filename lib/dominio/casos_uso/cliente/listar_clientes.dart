import '../../entidades/cliente.dart';
import '../../interfaces/cliente_repositorio_interface.dart';

class ListarClientes {
  final ClienteRepositorioInterface repositorio;

  ListarClientes(this.repositorio);

  Future<List<Cliente>> executar() async {
    return await repositorio.listarTodos();
  }
}
