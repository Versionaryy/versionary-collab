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
    notifyListeners();
    posts = await fetchPosts();
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

 
 
}