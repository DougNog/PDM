import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp( // Adicionado const
    debugShowCheckedModeBanner: false,
    home: TelaInicial(),
  ));
}

// ---------------- TELA INICIAL ----------------

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key}); // Construtor com super.key

  final String nome = "Douglas";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Inicial'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Ir para a segunda Tela'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SegundaTela(nome: nome)),
            );
          },
        ),
      ),
    );
  }
}

// ---------------- TELA SECUNDÁRIA ----------------

class SegundaTela extends StatelessWidget {
  final String nome;

  // Uso de super.key e required organizado
  const SegundaTela({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Secundária'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          'Olá, $nome! Bem-vindo à segunda tela.',
          style: const TextStyle(fontSize: 18), // Apenas um estilo extra opcional
        ),
      ),
    );
  }
}