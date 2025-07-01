import 'package:flutter/material.dart';
import 'package:mobile/models/post.dart';
import 'package:mobile/models/postFeed.dart';
import 'package:mobile/services/service_class.dart';

class DataClass extends ChangeNotifier {
  List<PostFeed>? posts;
  bool isLoading = false;
  late Post post;

  Future<void> getPosts() async {
    isLoading = true;
    posts = (await fetchPosts());
    isLoading = false;
    notifyListeners();
  }

  Future<void> getSpecificPost(int id) async {
    isLoading = true;
    notifyListeners();
    post = await fetchPostById(id);
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
      await getPosts();
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