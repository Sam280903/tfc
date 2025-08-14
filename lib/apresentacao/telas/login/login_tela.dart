import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../constantes/cores.dart';
import '../../../../servicos/autenticacao_servico.dart';

class LoginTela extends StatefulWidget {
  const LoginTela({super.key});

  @override
  State<LoginTela> createState() => _LoginTelaState();
}

class _LoginTelaState extends State<LoginTela> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _authServico = AutenticacaoServico();

  bool _ocultarSenha = true;
  String? _mensagemErro;

  Future<void> _fazerLogin() async {
    final email = _emailController.text.trim();
    final senha = _senhaController.text;

    if (_formKey.currentState!.validate()) {
      setState(() => _mensagemErro = null);

      try {
        final usuario = await _authServico.login(email, senha);
        if (usuario != null) {
          Navigator.pushReplacementNamed(context, "/home");
        }
      } catch (e) {
        setState(
            () => _mensagemErro = e.toString().replaceFirst("Exception: ", ""));
      }
    }
  }

  void _esqueciSenha() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Funcionalidade em desenvolvimento.")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.azulFundo,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/imagens/logo_gerenciar.png',
                    height: 160,
                  ),
                  const SizedBox(height: 32),
                  _campoTexto(
                    controller: _emailController,
                    label: "E-mail",
                    icon: Icons.email,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Informe o e-mail'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  _campoTexto(
                    controller: _senhaController,
                    label: "Senha",
                    icon: Icons.lock,
                    obscure: _ocultarSenha,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _ocultarSenha ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => _ocultarSenha = !_ocultarSenha);
                      },
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Informe a senha'
                        : null,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _esqueciSenha,
                      child: const Text(
                        "Esqueci a senha",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  if (_mensagemErro != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        _mensagemErro!,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _fazerLogin,
                      child: const Text("Entrar"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _campoTexto({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
