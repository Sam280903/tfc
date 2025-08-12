import '../../entidades/tecnico.dart';
import '../../interfaces/tecnico_repositorio_interface.dart';

class CadastrarTecnico {
  final TecnicoRepositorioInterface repositorio;

  CadastrarTecnico(this.repositorio);

  Future<void> executar(Tecnico tecnico) async {
    // Regras de negócio podem ser adicionadas aqui antes de salvar
    if (tecnico.nome.isEmpty || tecnico.email.isEmpty) {
      throw Exception('Nome e e-mail são obrigatórios.');
    }

    await repositorio.adicionar(tecnico);
  }
}
