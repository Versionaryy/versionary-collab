import 'dart:convert';
import 'package:mobile/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/postFeed.dart';

const String baseUrl = "http://localhost:8089";

Future<List<PostFeed>> fetchPosts() async {
  final response = await http.get(Uri.parse("$baseUrl/posts"));
  final List<dynamic> posts = jsonDecode(response.body);
  return posts.map((post) => PostFeed.fromJson(post as Map<String, dynamic>)).toList();
}

Future<Post> fetchPostById(int id) async {
  final response = await http.get(Uri.parse("$baseUrl/posts/$id"));
  final body = jsonDecode(response.body);
  return Post.fromJson(body as Map<String, dynamic>);
}

Future<Post?> createPost(Post post) async {
  final response = await http.post(
    Uri.parse("$baseUrl/posts"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(post.toJson()),
  );
  if (response.statusCode == 201 || response.statusCode == 200) {
    return Post.fromJson(jsonDecode(response.body));
  }
  return null;
}

Future<Post?> updatePost(int id, Post post) async {
  final response = await http.put(
    Uri.parse("$baseUrl/posts/$id"),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(post.toJson()),
  );
  if (response.statusCode == 200) {
    return Post.fromJson(jsonDecode(response.body));
  }
  return null;
}

Future<bool> deletePost(int id) async {
  final response = await http.delete(Uri.parse("$baseUrl/posts/$id"));
  return response.statusCode == 200 || response.statusCode == 204;
}