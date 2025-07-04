import 'package:flutter/material.dart';
import 'package:mobile/models/comment.dart';
import 'package:mobile/models/post.dart';
import 'package:mobile/services/data_class.dart';
import 'package:mobile/widgets/user_name_widget';
import 'package:provider/provider.dart';

// Widget para exibir um único item de comentário.
class ComentarioItem extends StatelessWidget {
  final Comment comentario;

  const ComentarioItem({super.key, required this.comentario});

  String _formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return '';
    timestamp = timestamp.toLocal();
    final now = DateTime.now().toLocal();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'agora';
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
            backgroundColor: const Color(0xFF7C3389).withOpacity(0.8),
            child: UserNameWidget(
              userId: comentario.userId!,
              showOnlyInitial: true,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    UserNameWidget(
                      userId: comentario.userId!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatTimestamp(comentario.createdAt),
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comentario.content ?? '',
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (String value) async {
              // TODO: A lógica aqui parece ser para um Post, não um Comentário.
              // Você provavelmente quer usar o ID do comentário, ex:
              // Provider.of<DataClass>(context, listen: false).removeComment(comentario.id);
              if (value == 'apagar') {
                // Lógica para apagar o comentário
              } else if (value == 'editar') {
                // Lógica para editar o comentário
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                  value: 'editar', child: Text('Editar')),
              const PopupMenuItem<String>(
                  value: 'apagar', child: Text('Apagar')),
            ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}

class TelaComentarios extends StatefulWidget {
  final int postId;

  const TelaComentarios({super.key, required this.postId});

  @override
  State<TelaComentarios> createState() => _TelaComentariosState();
}

class _TelaComentariosState extends State<TelaComentarios> {
  final TextEditingController _comentarioController = TextEditingController();
  bool _isPostingComment = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DataClass>(context, listen: false)
          .getSpecificPost(widget.postId);
    });
  }

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

  String _textoTag(CategoriaPost categoria) {
    switch (categoria) {
      case CategoriaPost.Bug:
        return "Bug";
      case CategoriaPost.Duvida:
        return "Dúvida";
      case CategoriaPost.Resolucao:
        return "Resolução";
    }
  }

  Future<void> _addComentario() async {
    if (_comentarioController.text.isNotEmpty) {
      setState(() => _isPostingComment = true);
      final dataProvider = Provider.of<DataClass>(context, listen: false);
      final postAtual = dataProvider.post;

      if (postAtual == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro: Não foi possível encontrar o post atual.')),
        );
        setState(() => _isPostingComment = false);
        return;
      }

      try {
        final novoComentario = Comment(null, _comentarioController.text,
            postAtual, null, null, {}, null, null);

        await dataProvider.addCommentToPost(novoComentario);
        _comentarioController.clear();
        FocusScope.of(context).unfocus();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao postar comentário: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isPostingComment = false);
        }
      }
    }
  }

  @override
  void dispose() {
    _comentarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Consumer<DataClass>(builder: (context, data, child) {
        if (data.isLoading && data.post?.id != widget.postId) {
          return const Center(child: CircularProgressIndicator());
        }

        if (data.post == null) {
          return const Center(child: Text('Post não encontrado.'));
        }

        final post = data.post!;
        final comentarios = post.comentarios?.toList() ?? [];

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF7C3389),
                    // Usamos o UserNameWidget aqui para exibir a inicial do nome
                    child: UserNameWidget(
                      userId: post.usuarioId!,
                      showOnlyInitial: true,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ),
                  const SizedBox(width: 8),
                  // E aqui para exibir o nome completo
                  UserNameWidget(
                    userId: post.usuarioId!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    onSelected: (String value) async {
                      if (value == 'apagar') {
                         Provider.of<DataClass>(context, listen: false)
                             .removePost(widget.postId);
                         Navigator.pop(context); 
                      } else if (value == 'editar') {
                        Navigator.pushNamed(context, '/criarpost',
                            arguments: widget.postId);
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                          value: 'editar', child: Text('Editar')),
                      const PopupMenuItem<String>(
                          value: 'apagar', child: Text('Apagar')),
                    ],
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(post.titulo ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              Text(post.descricao ?? '', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              if (post.categoria != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _corTag(post.categoria!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _textoTag(post.categoria!),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                'Comentários (${comentarios.length})',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF7C3389),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: comentarios.isEmpty
                    ? const Center(
                        child: Text(
                          'Nenhum comentário ainda. Seja o primeiro a comentar!',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: comentarios.length,
                        itemBuilder: (context, index) {
                          return ComentarioItem(
                            comentario: comentarios[index],
                          );
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
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton.small(
                    onPressed: _isPostingComment ? null : _addComentario,
                    backgroundColor: const Color(0xFF7C3389),
                    elevation: 0,
                    child: _isPostingComment
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}