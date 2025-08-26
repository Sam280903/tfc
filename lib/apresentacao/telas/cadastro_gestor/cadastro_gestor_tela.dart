// lib/apresentacao/telas/cadastro_gestor/cadastro_gestor_tela.dart

import 'package:flutter/material.dart';
import 'package:gerenciar/app/rotas.dart';
import 'package:gerenciar/servicos/autenticacao_servico.dart'; // Importar o serviço
import '../../../constantes/cores.dart';

class CadastroGestorTela extends StatefulWidget {
  const CadastroGestorTela({Key? key}) : super(key: key);

  @override
  State<CadastroGestorTela> createState() => _CadastroGestorTelaState();
}

class _CadastroGestorTelaState extends State<CadastroGestorTela> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authServico = AutenticacaoServico();

  String? _mensagemErro;
  bool _carregando = false;

  Future<void> _cadastrarGestor() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _carregando = true;
        _mensagemErro = null;
      });

      try {
        await _authServico.cadastrarPrimeiroGestor(
          nome: _nomeController.text.trim(),
          email: _emailController.text.trim(),
          senha: _senhaController.text,
        );
        // Se o cadastro for bem-sucedido, navega para a tela principal
        if (mounted) {
          Navigator.pushReplacementNamed(context, Rotas.home);
        }
      } catch (e) {
        setState(() {
          _mensagemErro = e.toString().replaceFirst("Exception: ", "");
        });
      } finally {
        setState(() {
          _carregando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.azulFundo,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/imagens/logo_gerenciar.png', height: 100),
                const SizedBox(height: 16),
                const Text(
                  'Cadastro do Gestor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nomeController,
                  decoration:
                      const InputDecoration(labelText: 'Nome (usuário)'),
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _senhaController,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) return 'Campo obrigatório';
                    if (value.length < 6)
                      return 'A senha deve ter no mínimo 6 caracteres';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmarSenhaController,
                  decoration:
                      const InputDecoration(labelText: 'Confirmar Senha'),
                  obscureText: true,
                  validator: (value) {
                    if (value != _senhaController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                if (_mensagemErro != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(_mensagemErro!,
                        style: const TextStyle(color: Colors.redAccent),
                        textAlign: TextAlign.center),
                  ),
                _carregando
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _cadastrarGestor,
                        child: const Text('CADASTRAR'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
