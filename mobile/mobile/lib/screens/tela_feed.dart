import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/models/post.dart';
import 'package:mobile/models/post_feed.dart';
import 'package:mobile/services/data_class.dart';
import 'package:mobile/widgets/user_name_widget';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';



class TelaFeed extends StatefulWidget {

  const TelaFeed({super.key});

  @override
  State<TelaFeed> createState() => _TelaFeedState();
}

class _TelaFeedState extends State<TelaFeed> {
  @override
  void initState() {
    super.initState();
  Future.microtask(() {
    final posts = Provider.of<DataClass>(context, listen: false);
    posts.getPosts();
  });
  }

  final Color roxo = const Color(0xFF7C3389);
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


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 75,
        title: Image.asset('assets/logo.png', height: 80),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/notificacoes');
            },
          ),
        ],
      ),
      body: Consumer<DataClass>(
        builder: (context, data, child) {
          if (data.isLoading && data.posts == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (data.posts == null || data.posts!.isEmpty) {
            return const Center(child: Text('Nenhum post encontrado.'));
          }

          return ListView.builder(
            itemCount: data.posts!.length,
            itemBuilder: (context, index) {
              final post = data.posts![index];
              return postCard(context, post);
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                                Navigator.pop(context, '/feed');
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/perfil');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: roxo,
        onPressed: () {
          Navigator.pushNamed(context, '/criarpost');
        },
        child: const Icon(
          Icons.add, 
          color: Colors.white,
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget postCard(BuildContext context, PostFeed post) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
                        context,
                        '/comentarios',
                        arguments: {
                          'postId':post.id,
                        },
                      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF7C3389),
                    child: Text(
                      "${post.usuarioId}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserNameWidget(userId: post.usuarioId!),
                       Text("${post.atualizado_em?.toLocal()}",
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                  const Spacer(),
                  PopupMenuButton<String>(
                    onSelected: (String value) async {
                      if (value == 'apagar') {
                        final bool? confirmed = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirmar Exclusão'),
                              content: const Text(
                                  'Você tem certeza que deseja apagar este post? Esta ação não pode ser desfeita.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: const Text('Apagar', style: TextStyle(color: Colors.red)),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirmed == true && mounted) {
                          Provider.of<DataClass>(context, listen: false).removePost(post.id!);
                        }
                      } else if (value == 'editar') {
                        // Navega para a tela de edição passando apenas o ID do post.
                        Navigator.pushNamed(context, '/criarpost', arguments: post.id);
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
                post.titulo ?? 'Título',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _corTag(post.categoria ?? CategoriaPost.Duvida),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:  Text(
                  _textoTag(post.categoria ?? CategoriaPost.Duvida),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(post.totalComentarios.toString(),
                      style: const TextStyle(fontSize: 14)),
                  const Icon(Icons.comment, size: 18),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/comentarios',
                        arguments: {
                          'postId': post.id,
                     
                          // 'postId': '',
                        },
                      );
                    },
                    child: const Text('Comentar'),
                  ),
                   const Spacer(),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share('${post.titulo}\n\n${post.descricao}');
                    }
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}