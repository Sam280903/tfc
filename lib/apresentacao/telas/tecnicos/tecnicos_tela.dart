// lib/apresentacao/telas/tecnicos/tecnicos_tela.dart

import 'package:flutter/material.dart';
import 'package:gerenciar/dados/repositorios/tecnico/tecnico_repositorio_adaptativo.dart';
import 'package:gerenciar/dominio/casos_uso/tecnico/listar_tecnicos.dart';
import 'package:gerenciar/dominio/entidades/tecnico.dart';
import 'cadastro_tecnico_tela.dart';

class TecnicosTela extends StatefulWidget {
  const TecnicosTela({super.key});

  @override
  State<TecnicosTela> createState() => _TecnicosTelaState();
}

class _TecnicosTelaState extends State<TecnicosTela> {
  late final ListarTecnicos _listarTecnicos;
  Future<List<Tecnico>>? _futureTecnicos;

  @override
  void initState() {
    super.initState();
    _listarTecnicos = ListarTecnicos(TecnicoRepositorioAdaptativo());
    _carregarTecnicos();
  }

  void _carregarTecnicos() {
    setState(() {
      _futureTecnicos = _listarTecnicos.executar();
    });
  }

  void _abrirFormularioCadastro() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CadastroTecnicoTela()),
    );

    if (resultado == true) {
      _carregarTecnicos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Técnicos"),
      ),
      // Botão flutuante para adicionar novos técnicos
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _abrirFormularioCadastro,
        icon: const Icon(Icons.add),
        label: const Text('NOVO TÉCNICO'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _carregarTecnicos(),
        child: FutureBuilder<List<Tecnico>>(
          future: _futureTecnicos,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar técnicos: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white)),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Nenhum técnico cadastrado.',
                    style: TextStyle(color: Colors.white70, fontSize: 16)),
              );
            }

            final tecnicos = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: tecnicos.length,
              itemBuilder: (context, index) {
                final tecnico = tecnicos[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: ListTile(
                    leading: const Icon(Icons.engineering_outlined),
                    title: Text(tecnico.nome),
                    subtitle: Text(tecnico.email),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Ação para editar/ver detalhes do técnico
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
