import 'dart:convert';

import 'package:mobile/models/post.dart';
import 'package:http/http.dart' as http;

Future<List<Post>> fetchPosts() async {
  final response = await http.get(Uri.parse("http://localhost:8089/posts"));
  final List<dynamic> posts = jsonDecode(response.body);
  return posts.map((post) => Post.fromJson(post as Map<String, dynamic>)).toList();
}