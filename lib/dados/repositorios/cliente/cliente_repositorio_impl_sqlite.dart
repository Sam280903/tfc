import 'package:gerenciar/dominio/entidades/cliente.dart';
import 'package:gerenciar/dominio/interfaces/cliente_repositorio_interface.dart';
import '../../fontes_dados/sqlite/cliente_sqlite.dart';
import '../../modelos/cliente_model.dart';

class ClienteRepositorioImplSQLite implements ClienteRepositorioInterface {
  final ClienteSQLite _fonteSQLite = ClienteSQLite();

  @override
  Future<void> adicionar(Cliente cliente) async {
    final model = ClienteModel.fromEntidade(cliente);
    await _fonteSQLite.adicionarCliente(model);
  }

  @override
  Future<void> atualizar(Cliente cliente) async {
    final model = ClienteModel.fromEntidade(cliente);
    await _fonteSQLite.atualizarCliente(model);
  }

  @override
  Future<void> inativar(String id) async {
    await _fonteSQLite.inativarCliente(id);
  }

  @override
  Future<Cliente?> buscarPorId(String id) async {
    final model = await _fonteSQLite.buscarPorId(id);
    return model?.toEntidade();
  }

  @override
  Future<List<Cliente>> listarTodos() async {
    final modelos = await _fonteSQLite.listarTodos();
    return modelos.map((m) => m.toEntidade()).toList();
  }
}
