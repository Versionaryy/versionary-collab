import 'package:flutter/material.dart';
import 'package:mobile/models/post.dart';
import 'package:mobile/services/service_class.dart';

class DataClass extends ChangeNotifier{
  List<Post>? posts;
  bool isLoading = false;

  getPosts() async {
    isLoading = true;
    posts = (await fetchPosts());
    isLoading = false;
    notifyListeners();
  }

  Future<void> removePost(int postId) async {
    try {
      await deletePost(postId);
      
      posts?.removeWhere((post) => post.id == postId);
      notifyListeners();
    } catch (e) {
      print('Erro ao apagar o post: $e');

      throw Exception('Falha ao apagar o post.');
    }
  }

  Future<void> editPost(int postId, Post updatedPost) async {
    try {

      await updatePost(postId, updatedPost);

      final index = posts?.indexWhere((post) => post.id == postId);
      if (index != null && index != -1) {
        posts?[index] = updatedPost;
        notifyListeners();
      }
    } catch (e) {
      print('Erro ao editar o post: $e');

      throw Exception('Falha ao editar o post.');
    }
  }

  Future<void> createPostService(Post post) async {
    try {
      await createPost(post); 
      await getPosts(); 
    } catch (e) {
      print('Erro ao criar o post: $e');
      throw Exception('Falha ao criar o post.');
    }
  }
}