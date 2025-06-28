import 'package:flutter/material.dart';
import 'package:mobile/models/post.dart';
import 'package:mobile/services/service_class.dart';

class DataClass extends ChangeNotifier{
  List<Post>? posts;
  bool isLoading = false;

  getPosts() async {
    isLoading = true;
    notifyListeners();
    posts = (await fetchPosts());
    isLoading = false;
    notifyListeners();
  }
}