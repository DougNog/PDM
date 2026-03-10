import 'package:flutter/material.dart';

void main() {
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false, home: InterruptorApp()),
    );
}

class InterruptorApp extends StatefulWidget {
  const InterruptorApp({super.key});

    @override
    _InterruptorAppState createState() => _InterruptorAppState();
}

class _InterruptorAppState extends State<InterruptorApp> {


    bool estAceso = false;

    void alternarLuz() {
        setState(() {
            estAceso = !estAceso;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: estAceso ? Colors.black : Colors.white,

            appBar: AppBar(
                backgroundColor: estAceso ? Colors.black : Colors.white,
                title: Text('Interruptor',
                style: TextStyle(color: estAceso ? Colors.white : Colors.black,
                    ),
                ),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                        Icon(
                            estAceso ? Icons.lightbulb : Icons.lightbulb_outline,
                            size: 100,
                            color: estAceso ? Colors.white : Colors.black,
                        ),

                        ElevatedButton(
                            onPressed: alternarLuz,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: estAceso ? Colors.white : Colors.black,
                            ),
                            child: Text(
                                "Interuptor",
                                style: TextStyle(color: estAceso ? Colors.black : Colors.white,
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}