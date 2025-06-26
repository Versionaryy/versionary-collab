import 'package:flutter/material.dart';

class TelaNotificacoes extends StatelessWidget {
  final Color roxo = const Color(0xFF7C3389);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: roxo,
        title: const Text('Notificações'),
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.comment, color: Colors.blueAccent),
            title: Text('Novo comentário na sua publicação.'),
          ),
          ListTile(
            leading: Icon(Icons.group, color: Colors.green),
            title: Text('Nova solicitação de colaboração.'),
          ),
        ],
      ),
    );
  }
}
