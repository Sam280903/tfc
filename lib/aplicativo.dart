import 'package:flutter/material.dart';
import 'apresentacao/telas/login/login_tela.dart';
import 'apresentacao/telas/home/home_tela.dart';
import 'apresentacao/telas/ordens_servico/ordens_servico_tela.dart';
import 'apresentacao/telas/tecnicos/tecnicos_tela.dart';
import 'apresentacao/telas/agendamentos/agendamentos_tela.dart';
import 'apresentacao/telas/clientes/clientes_tela.dart';
import 'apresentacao/telas/relatorios/relatorios_tela.dart';
import 'apresentacao/telas/tutoriais/tutoriais_tela.dart';
import 'apresentacao/telas/formas_pagamento/formas_pagamento_tela.dart';
import 'apresentacao/telas/comuntem/comuntem_tela.dart';
import 'app/rotas.dart';
import 'app/tema.dart';

class GerenciarApp extends StatelessWidget {
  const GerenciarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GerenciAR',
      debugShowCheckedModeBanner: false,
      theme: temaPrincipal,
      initialRoute: Rotas.login,
      routes: {
        Rotas.login: (context) => const LoginTela(),
        Rotas.home: (context) => const HomeTela(),
        Rotas.ordensServico: (_) => const OrdensServicoTela(),
        Rotas.tecnicos: (_) => const TecnicosTela(),
        Rotas.agendamentos: (_) => const AgendamentosTela(),
        Rotas.clientes: (_) => const ClientesTela(),
        Rotas.relatorios: (_) => const RelatoriosTela(),
        Rotas.tutoriais: (_) => const TutoriaisTela(),
        Rotas.formasPagamento: (_) => const FormasPagamentoTela(),
        Rotas.comuntem: (_) => const ComuntemTela(),
      },
    );
  }
}
