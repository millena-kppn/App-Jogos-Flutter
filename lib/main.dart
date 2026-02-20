import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de Jogos',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jogos Disponíveis')),
      body: const Center(
        child: Text(
          'Nenhum jogo disponível ainda',
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // depois vamos usar isso
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
