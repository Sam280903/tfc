// lib/apresentacao/telas/tecnicos/tecnicos_tela.dart

import 'package:flutter/material.dart';
import 'package:gerenciar/dados/repositorios/tecnico/tecnico_repositorio_adaptativo.dart';
import 'package:gerenciar/dominio/casos_uso/tecnico/listar_tecnicos.dart';
import 'package:gerenciar/dominio/entidades/tecnico.dart';
import '../../../constantes/cores.dart';

class TecnicosTela extends StatefulWidget {
  const TecnicosTela({Key? key}) : super(key: key);

  @override
  State<TecnicosTela> createState() => _TecnicosTelaState();
}

class _TecnicosTelaState extends State<TecnicosTela> {
  // Lógica para buscar os técnicos
  late final ListarTecnicos _listarTecnicos;
  Future<List<Tecnico>>? _futureTecnicos;

  @override
  void initState() {
    super.initState();
    // Inicializa o caso de uso com o repositório adaptativo
    _listarTecnicos = ListarTecnicos(TecnicoRepositorioAdaptativo());
    // Inicia a busca dos dados
    _carregarTecnicos();
  }

  void _carregarTecnicos() {
    setState(() {
      _futureTecnicos = _listarTecnicos.executar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.azulFundo,
      appBar: AppBar(
        title: const Text("Técnicos"),
        backgroundColor: Cores.azulCard,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Ação para cadastrar técnico
                print("Botão Cadastrar Técnico Pressionado!");
              },
              icon: const Icon(Icons.person_add),
              label: const Text("Cadastrar Técnico"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Cores.azulFundo,
                elevation: 4,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 24),
            // Widget que constrói a lista com base nos dados futuros
            Expanded(
              child: FutureBuilder<List<Tecnico>>(
                future: _futureTecnicos,
                builder: (context, snapshot) {
                  // Enquanto os dados estão carregando, mostra um spinner
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // Se ocorrer um erro
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            'Erro ao carregar técnicos: ${snapshot.error}'));
                  }
                  // Se não houver dados
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Nenhum técnico cadastrado.'));
                  }

                  // Se tudo deu certo, exibe a lista
                  final tecnicos = snapshot.data!;
                  return ListView.builder(
                    itemCount: tecnicos.length,
                    itemBuilder: (context, index) {
                      final tecnico = tecnicos[index];
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: const Icon(Icons.engineering,
                              color: Cores.azulFundo),
                          title: Text(tecnico.nome,
                              style: const TextStyle(color: Colors.black)),
                          subtitle: Text(tecnico.email,
                              style: const TextStyle(color: Colors.black54)),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // TODO: ação ao clicar em um técnico (editar/ver detalhes)
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
