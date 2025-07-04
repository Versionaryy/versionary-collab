import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile/models/login_response.dart';
import 'package:mobile/models/register_response.dart';

String baseUrl = "http://localhost:8003";
Future<LoginResponse> loginAPI(String email, String password) async {

  final response = await http.post(
    Uri.parse('$baseUrl/auth/login'),
    headers: {'Content-Type': 'application/json'},
    
    body: jsonEncode({'email': email, 'password': password}),
  );

  

  if (response.statusCode == 200) {
    return LoginResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Houve um erro ao fazer o login: ${response.statusCode}');
  }
}

Future<RegisterResponse> cadastroApi(String nome, String usuario, String email, String senha) async {

  final response = await http.post(
    Uri.parse('$baseUrl/users/register'),
    headers: {'Content-Type': 'application/json'},
    
    body: jsonEncode({'email': email, 'senha': senha, 'nome': nome, 'usuario': usuario}),
  );

  

  if (response.statusCode == 201) {
    return RegisterResponse(email: email, nome: nome, usuario: usuario);
  } else {
    throw Exception('Houve um erro ao fazer o cadastro: ${response.body}');
  }
}




