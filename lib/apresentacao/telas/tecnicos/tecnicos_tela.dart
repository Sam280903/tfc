import 'package:flutter/material.dart';
import '../../../constantes/cores.dart';

class TecnicosTela extends StatelessWidget {
  const TecnicosTela({Key? key}) : super(key: key);

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
              },
              icon: const Icon(Icons.person_add),
              label: const Text("Cadastrar Técnico"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Cores.azulFundo,
                elevation: 4,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Substituir por quantidade real
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.engineering),
                      title: Text("Técnico ${index + 1}"),
                      subtitle: const Text("E-mail: tecnico@email.com"),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // TODO: ação ao clicar em um técnico
                      },
                    ),
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
