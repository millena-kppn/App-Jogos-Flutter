import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'create_game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> jogos = [];

  @override
  void initState() {
    super.initState();
    carregarJogos();
  }

  // 🔹 Carregar jogos salvos
  Future<void> carregarJogos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jogosSalvos = prefs.getStringList('jogos');

    if (jogosSalvos != null) {
      setState(() {
        jogos = jogosSalvos;
      });
    }
  }

  // 🔹 Salvar jogos
  Future<void> salvarJogos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('jogos', jogos);
  }

  // 🔹 Remover jogo
  void removerJogo(int index) {
    setState(() {
      jogos.removeAt(index);
    });
    salvarJogos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jogos Disponíveis"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: jogos.isEmpty
          ? const Center(
              child: Text("Nenhum jogo disponível ainda"),
            )
          : ListView.builder(
              itemCount: jogos.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(jogos[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removerJogo(index),
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateGameScreen(
                onCreate: (novoJogo) {
                  setState(() {
                    jogos.add(novoJogo);
                  });
                  salvarJogos();
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}