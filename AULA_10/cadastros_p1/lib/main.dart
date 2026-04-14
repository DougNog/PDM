import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

void main() {
  // Inicializa SQLite FFI SOMENTE no desktop (Windows, Linux, macOS)
  // No Android/iOS o sqflite já funciona nativamente
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: AppCadastro()));
}

class AppCadastro extends StatefulWidget {
  const AppCadastro({super.key});

  @override
  _AppCadastroState createState() => _AppCadastroState();
}

class _AppCadastroState extends State<AppCadastro> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  List<Map<String, dynamic>> dados = [];
  int? idEditando; // se for null, está cadastrando; se tiver valor, está editando

  // Criar / abrir banco
  Future<Database> criarBanco() async {
    final caminho = await getDatabasesPath();
    final path = join(caminho, 'cadastro.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dados(id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, descricao TEXT)',
        );
      },
    );
  }

  // CREATE
  Future<void> inserirDado(String titulo, String descricao) async {
    final db = await criarBanco();
    await db.insert('dados', {'titulo': titulo, 'descricao': descricao});
    carregarDados();
  }

  // READ
  Future<void> carregarDados() async {
    final db = await criarBanco();
    final lista = await db.query('dados', orderBy: 'titulo ASC');

    setState(() {
      dados = lista;
    });
  }

  // UPDATE
  Future<void> atualizarDado(int id, String titulo, String descricao) async {
    final db = await criarBanco();
    await db.update(
      'dados',
      {'titulo': titulo, 'descricao': descricao},
      where: 'id = ?',
      whereArgs: [id],
    );
    carregarDados();
  }

  // DELETE
  Future<void> excluirDado(int id) async {
    final db = await criarBanco();
    await db.delete('dados', where: 'id = ?', whereArgs: [id]);
    carregarDados();
  }

  // Botão salvar (decide entre inserir ou atualizar)
  void salvar() {
    if (_tituloController.text.isNotEmpty &&
        _descricaoController.text.isNotEmpty) {
      if (idEditando == null) {
        inserirDado(_tituloController.text, _descricaoController.text);
      } else {
        atualizarDado(
          idEditando!,
          _tituloController.text,
          _descricaoController.text,
        );
        idEditando = null;
      }
      _tituloController.clear();
      _descricaoController.clear();
    }
  }

  // Preenche os campos pra editar
  void editar(Map<String, dynamic> item) {
    setState(() {
      idEditando = item['id'];
      _tituloController.text = item['titulo'];
      _descricaoController.text = item['descricao'];
    });
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App de Cadastro Inteligente")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _tituloController,
              decoration: InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: salvar,
            child: Text(idEditando == null ? 'Salvar' : 'Atualizar'),
          ),
          Expanded(
            child: dados.isEmpty
                ? Center(child: Text('Nenhum item cadastrado'))
                : ListView.builder(
                    itemCount: dados.length,
                    itemBuilder: (context, index) {
                      final item = dados[index];

                      return ListTile(
                        title: Text(item['titulo']),
                        subtitle: Text(item['descricao']),
                        onTap: () => editar(item),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            excluirDado(item['id']);
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