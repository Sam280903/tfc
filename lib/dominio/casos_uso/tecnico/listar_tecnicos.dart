import '../../entidades/tecnico.dart';
import '../../interfaces/tecnico_repositorio_interface.dart';

class ListarTecnicos {
  final TecnicoRepositorioInterface repositorio;

  ListarTecnicos(this.repositorio);

  Future<List<Tecnico>> executar() async {
    return await repositorio.listarTodos();
  }
}
