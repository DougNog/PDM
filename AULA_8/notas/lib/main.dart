import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ← estava faltando

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: AppNotas()),
  );
}

class AppNotas extends StatefulWidget {
  const AppNotas({super.key}); // ← adicione isso
  
  @override
  _AppNotasState createState() => _AppNotasState();
}

class _AppNotasState extends State<AppNotas> {
  TextEditingController controller = TextEditingController();
  List<String> notas = [];

  // PASSO 2 – Adicionar nota
  void adicionarNota() {
    if (controller.text.isNotEmpty) {
      setState(() {
        notas.add(controller.text);
        controller.clear();
      });
      salvarNotas();
    }
  }

  // PASSO 3 – Remover nota
  void removerNota(int index) {
    setState(() {
      notas.removeAt(index);
    });
    salvarNotas();
  }

  // PASSO 4 – Salvar notas
  void salvarNotas() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notas', notas);
  }

  // PASSO 5 – Carregar notas
  void carregarNotas() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notas = prefs.getStringList('notas') ?? [];
    });
  }

  // PASSO 6 – initState
  @override
  void initState() {
    super.initState();
    carregarNotas();
  }

  // PASSO 7 – Interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Minhas Notas')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Digite uma nota',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: adicionarNota,
              child: Text('Salvar Nota'),
            ),
            Expanded(
              child: notas.isEmpty
                  ? Center(child: Text('Nenhuma nota ainda'))
                  : ListView.builder(
                      itemCount: notas.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(notas[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => removerNota(index),
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