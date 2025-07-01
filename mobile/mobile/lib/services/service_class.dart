import 'dart:convert';
import 'package:mobile/models/post.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/post_create_dto.dart';
import 'package:mobile/models/postFeed.dart';

const String baseUrl = "http://localhost:8089";

// Função auxiliar para criar os cabeçalhos
Map<String, String> _getHeaders(String? token) {
  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
  if (token != null) {
    headers['Authorization'] = 'Bearer $token';
  }
  return headers;
}

Future<List<PostFeed>> fetchPosts(String? token) async {
  final response = await http.get(
    Uri.parse("$baseUrl/posts"),
    headers: _getHeaders(token),
  );
  if (response.statusCode != 200) {
    throw Exception('Falha ao carregar os posts: ${response.body}');
  }
  final List<dynamic> posts = jsonDecode(response.body);
  return posts.map((post) => PostFeed.fromJson(post as Map<String, dynamic>)).toList();
}

Future<Post> fetchPostById(int id, String token) async {
  final response = await http.get(
    Uri.parse("$baseUrl/posts/$id"),
    headers: _getHeaders(token),
  );
  if (response.statusCode != 200) {
    throw Exception('Falha ao carregar o post: ${response.body}');
  }
  final body = jsonDecode(response.body);
  return Post.fromJson(body as Map<String, dynamic>);
}

Future<void> deletePost(int postId, String token) async {
  final response = await http.delete(
    Uri.parse("$baseUrl/posts/$postId"),
    headers: _getHeaders(token),
  );

  if (response.statusCode != 200 && response.statusCode != 204) {
    throw Exception('Falha ao apagar o post: ${response.body}');
  }
}

Future<void> updatePost(int postId, Post post, String token) async {
  final response = await http.put(
    Uri.parse("$baseUrl/posts/$postId"),
    headers: _getHeaders(token),
    body: jsonEncode({
      'titulo': post.titulo,
      'descricao': post.descricao,
      // O backend espera o índice do enum (0 para Bug, 1 para Duvida, etc.)
      'categoria': post.categoria?.index,
    }),
  );

  if (response.statusCode != 200 && response.statusCode != 204) {
    throw Exception('Falha ao atualizar o post: ${response.body}');
  }
}

Future<void> createPost(PostCreateDto post, String token) async {
  final response = await http.post(
    Uri.parse("$baseUrl/posts"),
    headers: _getHeaders(token),
    body: jsonEncode(post.toJson()),
  );

  if (response.statusCode != 201) {
    throw Exception('Falha ao criar o post: ${response.body}');
  }
}
