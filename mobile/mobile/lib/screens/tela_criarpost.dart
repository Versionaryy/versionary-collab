import 'package:flutter/material.dart';
import 'package:mobile/models/post.dart';
import 'package:mobile/models/post_create_dto.dart';
import 'package:mobile/services/data_class.dart';
import 'package:provider/provider.dart';

class TelaCriarPost extends StatefulWidget {
  const TelaCriarPost({super.key});

  @override
  State<TelaCriarPost> createState() => _TelaCriarPostState();
}

class _TelaCriarPostState extends State<TelaCriarPost> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _conteudoController = TextEditingController();

  int? _editingPostId;
  bool _isEditing = false;
  CategoriaPost _categoriaSelecionada = CategoriaPost.Duvida;

  bool _isLoading = false; 
  bool _isSaving = false; 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null && arguments is int && _editingPostId == null) {
      _editingPostId = arguments;
      _isEditing = true;
      _fetchPostDetails();
    }
  }

  Future<void> _fetchPostDetails() async {
    setState(() => _isLoading = true);
    try {
      final dataProvider = Provider.of<DataClass>(context, listen: false);
      await dataProvider.getSpecificPost(_editingPostId!);
      final post = dataProvider.post;

      if (post == null) {
        // This should not happen if getSpecificPost succeeds, but it's a good safeguard.
        throw Exception("Dados do post não encontrados após a busca.");
      }

      _tituloController.text = post.titulo ?? '';
      _conteudoController.text = post.descricao ?? '';
      _categoriaSelecionada = post.categoria ?? CategoriaPost.Duvida;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar post: $e')),
        );
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _submitForm() async {
    if (_tituloController.text.isEmpty || _conteudoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Título e conteúdo não podem estar vazios.')),
      );
      return;
    }

    setState(() => _isSaving = true);
    final provider = Provider.of<DataClass>(context, listen: false);

    try {
      if (_isEditing) {
        final originalPost = provider.post;
        if (originalPost == null) {
          throw Exception(
              "Não foi possível encontrar os dados do post para editar.");
        }

        final updatedPost = Post(
          _editingPostId,
          _tituloController.text,
          _conteudoController.text,
          originalPost.usuarioId,
          originalPost.comentarios,
          _categoriaSelecionada,
        );
        await provider.editPost(_editingPostId!, updatedPost);
      } else {
        final novoPost = PostCreateDto(
          titulo: _tituloController.text,
          descricao: _conteudoController.text,
          categoria: _categoriaSelecionada,
        );
        await provider.createPostService(novoPost);
      }

      if (mounted) {
        final message = _isEditing ? 'Post atualizado com sucesso!' : 'Post criado com sucesso!';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        final message = _isEditing ? 'Erro ao atualizar o post.' : 'Erro ao criar o post.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$message: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Widget _tagButton(String label, CategoriaPost categoria) {
    final isSelected = _categoriaSelecionada == categoria;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF7C3389) : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      onPressed: () => setState(() => _categoriaSelecionada = categoria),
      child: Text(label),
    );
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
          if (!_isLoading)
            TextButton(
              onPressed: _isSaving ? null : _submitForm,
              child: _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      _isEditing ? 'SALVAR' : 'POSTAR',
                      style: const TextStyle(
                        color: Color(0xFF7C3389),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _tagButton('Bug', CategoriaPost.Bug),
                      _tagButton('Dúvida', CategoriaPost.Duvida),
                      _tagButton('Resolução', CategoriaPost.Resolucao),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
