// lib/apresentacao/telas/home/home_tela.dart

import 'package:flutter/material.dart';
import 'package:gerenciar/servicos/autenticacao_servico.dart';
import '../../../constantes/cores.dart';
import '../../../app/rotas.dart';

class HomeTela extends StatefulWidget {
  const HomeTela({super.key});

  @override
  State<HomeTela> createState() => _HomeTelaState();
}

class _HomeTelaState extends State<HomeTela> {
  // Variável para armazenar a saudação personalizada
  String _saudacaoUsuario = "Olá...";

  @override
  void initState() {
    super.initState();
    _carregarDadosUsuario();
  }

  // Método para buscar os dados do usuário e atualizar a tela
  void _carregarDadosUsuario() async {
    final dados = await AutenticacaoServico().buscarDadosUsuarioLogado();
    if (dados != null && mounted) {
      setState(() {
        // Formata a saudação com o nome e o perfil vindos do Firestore
        final nome = dados['nome'] ?? 'Usuário';
        final perfil = dados['perfil'] ?? '';
        _saudacaoUsuario = "Olá, $nome - $perfil";
      });
    } else {
      _saudacaoUsuario = "Olá, Usuário";
    }
  }

  // Método para fazer logout
  void _fazerLogout() async {
    await AutenticacaoServico().logout();
    if (mounted) {
      Navigator.pushReplacementNamed(context, Rotas.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.azulFundo,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/imagens/logo_gerenciar.png',
          height: 75,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new, color: Colors.white),
            onPressed: _fazerLogout, // Chama o método de logout
          )
        ],
      ),
      body: Stack(
        children: [
          // Marca d'água
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Center(
                child: Image.asset(
                  'assets/imagens/logo_gerenciar.png',
                  width: 280,
                ),
              ),
            ),
          ),
          // Conteúdo da tela
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Exibe a saudação dinâmica
                Text(
                  _saudacaoUsuario,
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      _buildItem(Icons.assignment, 'Ordens de Serviço',
                          Rotas.ordensServico, context),
                      _buildItem(
                          Icons.person, 'Técnicos', Rotas.tecnicos, context),
                      _buildItem(Icons.calendar_today, 'Agendamentos',
                          Rotas.agendamentos, context),
                      _buildItem(Icons.people_alt, 'Clientes', Rotas.clientes,
                          context),
                      _buildItem(Icons.bar_chart, 'Relatórios',
                          Rotas.relatorios, context),
                      _buildItem(Icons.menu_book, 'Tutoriais', Rotas.tutoriais,
                          context),
                      _buildItem(Icons.settings, 'Formas de Pagamento',
                          Rotas.formasPagamento, context),
                      _buildItem(Icons.person_outline, 'Comuntem',
                          Rotas.comuntem, context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
      IconData icone, String titulo, String rota, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Cores.azulCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, rota);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, color: Colors.white, size: 36),
            const SizedBox(height: 8),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
