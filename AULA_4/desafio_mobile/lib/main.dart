import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/// APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
    );
  }
}

/// TELA PRINCIPAL
class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  // =========================
  // 1) ESTADO (DADOS)
  // =========================
  final List<String> _tarefas = [];

  // =========================
  // 2) CONTROLLER (INPUT)
  // =========================
  final TextEditingController _controller = TextEditingController();

  // =========================
  // 3) AÇÕES (FUNÇÕES)
  // =========================
  void _adicionarTarefa() {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      _tarefas.add(texto);
    });

    _controller.clear();
  }

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // =========================
  // 4) UI (TELA)
  // =========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas (${_tarefas.length})"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _campoTexto(),
            const SizedBox(height: 10),
            _botaoAdicionar(),
            const SizedBox(height: 10),
            _listaTarefas(),
          ],
        ),
      ),
    );
  }

  Widget _campoTexto() {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        labelText: "Nova Tarefa",
        border: OutlineInputBorder(),
      ),
      onSubmitted: (_) => _adicionarTarefa(), // Enter adiciona
    );
  }

  Widget _botaoAdicionar() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _adicionarTarefa,
        child: const Text("Adicionar"),
      ),
    );
  }

  Widget _listaTarefas() {
    if (_tarefas.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text(
            "Nenhuma tarefa adicionada",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: _tarefas.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_tarefas[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _removerTarefa(index),
              ),
            ),
          );
        },
      ),
    );
  }
}