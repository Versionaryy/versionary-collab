import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/models/post.dart';
import 'package:mobile/services/data_class.dart';
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

  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<DataClass>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 75,
        title: Image.asset(
          'assets/logo.png',
          height: 80,
        ),
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
      body:  
      posts.posts == null
          ? const Center(child: CircularProgressIndicator())
          : posts.posts!.isEmpty
              ? const Center(child: Text('Nenhum post encontrado'))
              :
      ListView.builder(
        itemBuilder: (context, index) {
          final post = posts.posts![index];
          final username = 'Usuário';
          return postCard(context, username, post);
        },
        itemCount: posts.posts?.length ?? 0,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {},
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

  Widget postCard(BuildContext context, String username, Post post) {
    final String content = post.descricao ?? 'Sem descrição';
    final String title = post.titulo ?? 'Sem Título';

    return Card(
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
                    username[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const Text(
                      '15 hours ago',
                      style: TextStyle(fontSize: 12)),
                  ],
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (String value) async { 
                    if (value == 'editar') {
                        Navigator.pushNamed(
                        context,
                        '/criarpost',
                        arguments: post,
                      );
                    } else if (value == 'apagar') {
                      try {
                        await Provider.of<DataClass>(context, listen: false).removePost(post.id!);
                        
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Post apagado com sucesso!'), backgroundColor: Colors.green),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Erro ao apagar o post.'), backgroundColor: Colors.red),
                          );
                        }
                      }
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
              content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //   decoration: BoxDecoration(
            //     color: Colors.orange,
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: const Text(
            //     'Dúvida',
            //     style: TextStyle(color: Colors.white, fontSize: 12),
            //   ),
            // ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.comment, size: 18),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/comentarios',
                      arguments: {
                        'username': username,
                        'conteudo': content,
                        // 'tag': 'Dúvida',
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
    );
  }
}
