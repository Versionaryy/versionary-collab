import 'package:flutter/material.dart';
import 'package:mobile/models/post.dart';
import 'package:mobile/services/data_class.dart';
import 'package:provider/provider.dart';

class TelaCriarPost extends StatefulWidget {
  const TelaCriarPost({super.key});

  @override
  _TelaCriarPostState createState() => _TelaCriarPostState();
}

class _TelaCriarPostState extends State<TelaCriarPost> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _conteudoController = TextEditingController();

  Post? postParaEditar;
  bool _isEditing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (postParaEditar == null) {
      final post = ModalRoute.of(context)?.settings.arguments as Post?;
      if (post != null) {
        setState(() {
          postParaEditar = post;
          _isEditing = true;
          _tituloController.text = post.titulo ?? '';
          _conteudoController.text = post.descricao ?? '';
        });
      }
    }
  }

  void _submitForm() async {
    final provider = Provider.of<DataClass>(context, listen: false);

    FocusScope.of(context).unfocus();

    if (_isEditing) {
      final updatedPost = Post(
        postParaEditar!.id,
        _tituloController.text,
        _conteudoController.text,
        postParaEditar!.usuarioId,
        postParaEditar!.comentarios,
      );

      try {
        await provider.editPost(postParaEditar!.id!, updatedPost);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Post atualizado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erro ao atualizar o post.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _conteudoController.dispose();
    super.dispose();
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
        title: Text(
          _isEditing ? 'EDITE O POST' : 'CRIE UM POST',
          style: const TextStyle(
            color: Color(0xFF7C3389),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _submitForm,
            child: Text(
              _isEditing ? 'Salvar' : 'Postar',
              style: const TextStyle(
                color: Color(0xFF7C3389),
                fontWeight: FontWeight.bold,
              ),
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
            // const SizedBox(height: 12),
            // Row(
            //   children: [
            //     _tagButton('Bug', Colors.red, Colors.red, Colors.red),
            //     _tagButton('Dúvida', Colors.orange, Colors.orange, Colors.orange),
            //     _tagButton('Resolução', Colors.green, Colors.green, Colors.green),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
