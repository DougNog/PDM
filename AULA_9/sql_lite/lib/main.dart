import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AppBanco(),
  ));
}

class AppBanco extends StatefulWidget {
  @override
  _AppBancoState createState() => _AppBancoState();
}

class _AppBancoState extends State<AppBanco> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> tarefas = [];

  Future<Database> criarBanco() async {
    final caminho = await getDatabasesPath();
    final path = join(caminho, 'banco.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tarefas(id INTEGER PRIMARY KEY, nome TEXT)',
        );
      },
    );
  }

  Future<void> inserirTarefa(String nome) async {
    final db = await criarBanco();
    await db.insert('tarefas', {'nome': nome});
    carregarTarefas();
  }

  Future<void> carregarTarefas() async {
    final db = await criarBanco();
    final lista = await db.query('tarefas');

    setState(() {
      tarefas = lista;
    });
  }

  Future<void> excluirTarefa(int id) async {
    final db = await criarBanco();
    await db.delete('tarefas', where: 'id = ?', whereArgs: [id]);
    carregarTarefas();
  }

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meu Banco de Dados")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Nova Tarefa',
                border: OutlineInputBorder(), // Corrigido posicionamento da vírgula
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                inserirTarefa(_controller.text);
                _controller.clear();
              }
            },
            child: Text('Adicionar Tarefa'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                // Aqui você já selecionou a tarefa correta pelo index
                final tarefa = tarefas[index]; 
                
                return ListTile(
                  // Remova o [index] daqui, use apenas a variável 'tarefa'
                  title: Text(tarefa['nome']), 
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Remova o [index] daqui também
                      excluirTarefa(tarefa['id']);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}