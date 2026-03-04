import 'package:flutter/material.dart';
import 'home_screen.dart';

class GameDetailsScreen extends StatefulWidget {
  final Jogo jogo;
  final String criador;

  const GameDetailsScreen({
    super.key,
    required this.jogo,
    required this.criador,
  });

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  int participantes = 0;

  void participar() {
    setState(() {
      participantes++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final jogo = widget.jogo;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do Jogo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  jogo.nome,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text("Descrição: ${jogo.descricao}"),
                const SizedBox(height: 10),
                Text("Data: ${jogo.data}"),
                const SizedBox(height: 10),
                Text("Local: ${jogo.local}"),
                const SizedBox(height: 10),
                Text("Criado por: ${widget.criador}"),
                const SizedBox(height: 20),
                Text("Participantes: $participantes"),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: participar,
                  child: const Text("Participar"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}