import 'package:flutter/material.dart';

void main() {
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false, home: HumorApp()),
    );
}

class HumorApp extends StatefulWidget {
  const HumorApp({super.key});

    @override
    _HumorAppState createState() => _HumorAppState();
}

class _HumorAppState extends State<HumorApp> {

    int estadoHumor = 0;

    void mudarHumor() {
        setState(() {
            estadoHumor++;
            if (estadoHumor > 2) estadoHumor = 0;
        });
    }

    @override
    Widget build(BuildContext context) {

        return Scaffold(
            appBar: AppBar(
                title: Text('Humor'),
            ),

            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                        Icon(
                            estadoHumor == 0
                                ? Icons.sentiment_satisfied
                                : estadoHumor == 1
                                    ? Icons.sentiment_neutral
                                    : Icons.sentiment_dissatisfied,
                            size: 120,
                        ),

                        SizedBox(height: 20),

                        Text(
                            estadoHumor == 0
                                ? "Feliz"
                                : estadoHumor == 1
                                    ? "Neutro"
                                    : "Bravo",
                            style: TextStyle(fontSize: 28),
                        ),

                        SizedBox(height: 20),

                        ElevatedButton(
                            onPressed: mudarHumor,
                            child: Text("Mudar Humor"),
                        ),
                    ],
                ),
            ),
        );
    }
}