import 'package:flutter/material.dart';
import 'game_details_screen.dart';

class Jogo {
  String nome;
  String descricao;
  String data;
  String local;

  Jogo({
    required this.nome,
    required this.descricao,
    required this.data,
    required this.local,
  });
}

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Jogo> jogos = [];

  void adicionarJogo() {
    final nomeController = TextEditingController();
    final descricaoController = TextEditingController();
    final dataController = TextEditingController();
    final localController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Criar Jogo"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: "Nome do Jogo"),
              ),
              TextField(
                controller: descricaoController,
                decoration: const InputDecoration(labelText: "Descrição"),
              ),
              TextField(
                controller: dataController,
                decoration: const InputDecoration(labelText: "Data"),
              ),
              TextField(
                controller: localController,
                decoration: const InputDecoration(labelText: "Local"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              if (nomeController.text.isEmpty) return;

              setState(() {
                jogos.add(
                  Jogo(
                    nome: nomeController.text,
                    descricao: descricaoController.text,
                    data: dataController.text,
                    local: localController.text,
                  ),
                );
              });

              Navigator.pop(context);
            },
            child: const Text("Criar"),
          ),
        ],
      ),
    );
  }

  void removerJogo(int index) {
    setState(() {
      jogos.removeAt(index);
    });
  }

  void logout() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogos - ${widget.username}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: adicionarJogo,
        child: const Icon(Icons.add),
      ),
      body: jogos.isEmpty
          ? const Center(child: Text("Nenhum jogo criado"))
          : ListView.builder(
              itemCount: jogos.length,
              itemBuilder: (context, index) {
                final jogo = jogos[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(jogo.nome),
                    subtitle: Text(jogo.data),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GameDetailsScreen(
                            jogo: jogo,
                            criador: widget.username,
                          ),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removerJogo(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}