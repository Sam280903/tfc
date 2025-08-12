import 'package:flutter/material.dart';
import '../../../constantes/cores.dart';
import '../../../app/rotas.dart';

class HomeTela extends StatelessWidget {
  const HomeTela({super.key});

  @override
  Widget build(BuildContext context) {
    final String nomeUsuario = "João – Gestor";

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
            onPressed: () {
              Navigator.pushReplacementNamed(context, Rotas.login);
            },
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
                Text(
                  'Olá, $nomeUsuario',
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
