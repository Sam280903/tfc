import 'package:flutter/material.dart';

class TutoriaisTela extends StatelessWidget {
  const TutoriaisTela({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutoriais'),
      ),
      body: const Center(
        child: Text(
          'Tela em construção...',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
