import '../../dominio/interfaces/tecnico_repositorio_interface.dart';
import '../../dominio/entidades/tecnico.dart';
import '../modelos/tecnico_model.dart';
import '../fontes_dados/firebase/tecnico_firebase.dart';

class TecnicoRepositorioImpl implements TecnicoRepositorioInterface {
  final TecnicoFirebase _fonteFirebase = TecnicoFirebase();

  @override
  Future<void> adicionar(Tecnico tecnico) async {
    final model = TecnicoModel(
      id: tecnico.id,
      nome: tecnico.nome,
      email: tecnico.email,
      telefone: tecnico.telefone,
      ativo: tecnico.ativo,
    );
    await _fonteFirebase.adicionarTecnico(model);
  }

  @override
  Future<void> atualizar(Tecnico tecnico) async {
    final model = TecnicoModel(
      id: tecnico.id,
      nome: tecnico.nome,
      email: tecnico.email,
      telefone: tecnico.telefone,
      ativo: tecnico.ativo,
    );
    await _fonteFirebase.atualizarTecnico(model);
  }

  @override
  Future<void> inativar(String id) async {
    await _fonteFirebase.inativarTecnico(id);
  }

  @override
  Future<Tecnico?> buscarPorId(String id) async {
    final model = await _fonteFirebase.buscarPorId(id);
    if (model == null) return null;

    return Tecnico(
      id: model.id,
      nome: model.nome,
      email: model.email,
      telefone: model.telefone,
      ativo: model.ativo,
    );
  }

  @override
  Future<List<Tecnico>> listarTodos() async {
    final modelos = await _fonteFirebase.listarTodos();
    return modelos
        .map((m) => Tecnico(
              id: m.id,
              nome: m.nome,
              email: m.email,
              telefone: m.telefone,
              ativo: m.ativo,
            ))
        .toList();
  }
}
