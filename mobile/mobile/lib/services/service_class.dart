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



Future<void> deletePost(int postId) async {
  final response = await http.delete(
    Uri.parse("http://localhost:8089/posts/$postId"),
  );

  if (response.statusCode != 204) {
    throw Exception('Falha ao apagar o post.');
  }
}

Future<void> updatePost(int postId, Post post) async {
  final response = await http.put(
    Uri.parse("http://localhost:8089/posts/$postId"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'titulo': post.titulo,
      'descricao': post.descricao,
    }),
  );

  if (response.statusCode != 204) {
    throw Exception('Falha ao atualizar o post.');
  }
}


Future<Post> createPost(Post post) async {
  final response = await http.post(
    Uri.parse("http://localhost:8089/posts"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(post.toJson()), 
  );

  if (response.statusCode == 201) {
    return Post.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Falha ao criar o post.');
  }
}


