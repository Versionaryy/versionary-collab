import 'package:flutter/material.dart';
import 'package:mobile/models/post.dart';

class Comentario {
  final String username;
  final String content;
  final DateTime timestamp;

  Comentario({
    required this.username,
    required this.content,
    required this.timestamp,
  });
}

class ComentarioItem extends StatelessWidget {
  final Comentario comentario;

  const ComentarioItem({super.key, required this.comentario});

  String _formatTimestamp(DateTime timestamp) {
    timestamp = timestamp.toLocal();
    final now = DateTime.now().toLocal();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} dias atrás';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} horas atrás';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutos atrás';
    } else {
      return 'agora mesmo';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFE0BBE4),
            child: Text(
              comentario.username[0].toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comentario.username,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(
                  _formatTimestamp(comentario.timestamp),
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  comentario.content,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TelaComentarios extends StatefulWidget {

  final int postId;

  const TelaComentarios({
    super.key,
    required this.postId,
  });

  @override
  State<TelaComentarios> createState() => _TelaComentariosState();
}

class _TelaComentariosState extends State<TelaComentarios> {
  final TextEditingController _comentarioController = TextEditingController();
  final List<Comentario> _comentarios = [];

  Color _corTag(CategoriaPost categoria) {
    switch (categoria) {
      case CategoriaPost.Bug:
        return Colors.red;
      case CategoriaPost.Duvida:
        return Colors.orange;
      case CategoriaPost.Resolucao:
        return Colors.green;
    }
  }
   void _addComentario() {
    if (_comentarioController.text.isNotEmpty) {
      setState(() {
        _comentarios.add(
          Comentario(
            username: 'Você',
            content: _comentarioController.text,
            timestamp: DateTime.now(),
          ),
        );
        _comentarioController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comentário postado!')),
      );
    }
  }

  @override
  void dispose() {
    _comentarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var corTag = _corTag(CategoriaPost.Duvida); 

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'COMENTÁRIOS',
          style: TextStyle(
            color: Color(0xFF7C3389),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF7C3389),
                  child: Text(
                    // widget.username[0].toUpperCase(),
                    "a",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // widget.username,
                      'a',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const Text(
                      '15 hours ago',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    if (value == 'editar') {
                      print('Editar post:');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ação: Editar Post')),
                      );
                    } else if (value == 'apagar') {
                      print('Apagar post:');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Ação: Apagar Post ')),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'editar',
                      child: Text('Editar'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'apagar',
                      child: Text('Apagar'),
                    ),
                  ],
                  icon: const Icon(Icons.more_vert),
                  tooltip: '',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              // widget.conteudo,
              'a',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                // color: corTag,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                // widget.tag,
                'Dúvida',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(), //separador entre o post e os comentários
            const SizedBox(height: 8),
            Text(
              'Comentários (${_comentarios.length})',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF7C3389),
              ),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: _comentarios.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhum comentário ainda. Seja o primeiro a comentar!',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _comentarios.length,
                      itemBuilder: (context, index) {
                        return ComentarioItem(comentario: _comentarios[index]);
                      },
                    ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _comentarioController,
                    minLines: 1, 
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Digite seu comentário...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20), 
                        borderSide: BorderSide.none, 
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF3E5F5), 
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton.small( 
                  onPressed: _addComentario,
                  backgroundColor: const Color(0xFF7C3389),
                  elevation: 0, 
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}