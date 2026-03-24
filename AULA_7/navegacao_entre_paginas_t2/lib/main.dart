import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TelaInicial(),
  ));
}

// ---------------- TELA INICIAL ----------------

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Contatos'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Ana – (11) 91111-1111'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SegundaTela(nome: 'Ana', telefone: '(11) 91111-1111'),
                ));
              },
            ),
            ElevatedButton(
              child: const Text('Carlos – (21) 92222-2222'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SegundaTela(nome: 'Carlos', telefone: '(21) 92222-2222'),
                ));
              },
            ),
            ElevatedButton(
              child: const Text('Mariana – (31) 93333-3333'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SegundaTela(nome: 'Mariana', telefone: '(31) 93333-3333'),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- TELA SECUNDÁRIA ----------------

class SegundaTela extends StatelessWidget {
  final String nome;
  final String telefone;

  const SegundaTela({super.key, required this.nome, required this.telefone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nome: $nome', style: const TextStyle(fontSize: 18)),
            Text('Telefone: $telefone', style: const TextStyle(fontSize: 18)),
            ElevatedButton(
              child: const Text('Voltar'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}   