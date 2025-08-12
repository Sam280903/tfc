import '../../entidades/tecnico.dart';
import '../../interfaces/tecnico_repositorio_interface.dart';

class AtualizarTecnico {
  final TecnicoRepositorioInterface repositorio;

  AtualizarTecnico(this.repositorio);

  Future<void> executar(Tecnico tecnico) async {
    if (tecnico.id.isEmpty) {
      throw Exception('ID do técnico é obrigatório para atualização.');
    }

    await repositorio.atualizar(tecnico);
  }
}
