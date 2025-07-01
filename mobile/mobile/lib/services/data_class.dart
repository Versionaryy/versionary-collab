import 'package:flutter/material.dart';
import 'package:mobile/models/comment.dart';
import 'package:mobile/models/post.dart';
import 'package:mobile/models/post_create_dto.dart';
import 'package:mobile/models/post_feed.dart';
import 'package:mobile/services/service_class.dart';

class DataClass extends ChangeNotifier {
  String? _token;
  List<PostFeed>? posts;
  bool isLoading = false;
  Post? post;

  DataClass(this._token);

  void updateToken(String? newToken) {
    _token = newToken;
  }

  void _ensureAuthenticated() {
    if (_token == null) {
      throw Exception('Usuário não autenticado. Faça o login novamente.');
    }
  }

  Future<void> getPosts() async {
    isLoading = true;
    notifyListeners();
    posts = (await fetchPosts(_token));
    isLoading = false;
    notifyListeners();
  }

  Future<void> getSpecificPost(int id) async {
    _ensureAuthenticated();
    isLoading = true;
    notifyListeners();
    post = await fetchPostById(id, _token!);
    isLoading = false;
    notifyListeners();
  }

  Future<void> removePost(int postId) async {
    _ensureAuthenticated();
    try {
      await deletePost(postId, _token!);

      posts?.removeWhere((post) => post.id == postId);
      notifyListeners();
    } catch (e) {
      print('Erro ao apagar o post: $e');
      throw Exception('Falha ao apagar o post.');
    }
  }

  Future<void> editPost(int postId, Post updatedPost) async {
    _ensureAuthenticated();
    try {
      await updatePost(postId, updatedPost, _token!);
      await getPosts();
    } catch (e) {
      print('Erro ao editar o post: $e');
      throw Exception('Falha ao editar o post.');
    }
  }

  Future<void> createPostService(PostCreateDto post) async {
    _ensureAuthenticated();
    try {
      await createPost(post, _token!);
      await getPosts();
    } catch (e) {
      print('Erro ao criar o post: $e');
      throw Exception('Falha ao criar o post.');
    }
  }

  Future<void> addCommentToPost(Comment comentario) async {
    _ensureAuthenticated();
    try {
      await createComment(comentario, _token!);
      await getSpecificPost(comentario.post?.id ?? 0); 
    } catch (e) {
      print('Erro ao adicionar comentário: $e');
      throw Exception('Falha ao adicionar comentário.');
    }
  }
}