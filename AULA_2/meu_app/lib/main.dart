import 'package:flutter/material.dart';

void main() {
  runApp(meuapp());
}

class meuapp extends StatelessWidget {
  const meuapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Lista de Tarefas',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.radio_button_unchecked),
              title: Text('Estudar Flutter'),
              trailing: Icon(Icons.delete),
            ),

            ListTile(
              leading: Icon(Icons.radio_button_unchecked),
              title: Text('Praticar Dart'),
              trailing: Icon(Icons.delete),
            ),
            ListTile(
              leading: Icon(Icons.radio_button_unchecked),
              title: Text('Criar um App'),
              trailing: Icon(Icons.delete),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(onPressed: () {}, backgroundColor: Colors.black, child: Icon(Icons.add, color: Colors.white),),

      ),
    );
  }
}
