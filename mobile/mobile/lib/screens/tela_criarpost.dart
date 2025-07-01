import 'package:flutter/material.dart';

class TelaCriarPost extends StatefulWidget {
  @override
  _TelaCriarPostState createState() => _TelaCriarPostState();
}

class _TelaCriarPostState extends State<TelaCriarPost> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _conteudoController = TextEditingController();

  String? tagSelecionada;

  Widget _tagButton(String tag, Color corTexto, Color corBorda, Color corFundoSelecionado) {
    final selecionado = tagSelecionada == tag;
    return GestureDetector(
      onTap: () {
        setState(() {
          tagSelecionada = tag;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: selecionado ? corFundoSelecionado : Colors.transparent,
          border: Border.all(color: corBorda),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          tag,
          style: TextStyle(
            color: selecionado ? Colors.white : corTexto,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'CRIE UM POST',
          style: TextStyle(color: Color(0xFF7C3389), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // ação de postar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Post enviado!')),
              );
              Navigator.pop(context);
            },
            child: const Text(
              'Postar',
              style: TextStyle(color: Color(0xFF7C3389), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                hintText: 'Título do post',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _conteudoController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Digite aqui...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _tagButton('Bug', Colors.red, Colors.red, Colors.red),
                _tagButton('Dúvida', Colors.orange, Colors.orange, Colors.orange),
                _tagButton('Resolução', Colors.green, Colors.green, Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
