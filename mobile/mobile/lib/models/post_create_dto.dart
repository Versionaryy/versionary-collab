import 'package:mobile/models/post.dart';

class PostCreateDto {
  String titulo;
  String descricao;
  CategoriaPost categoria;

  PostCreateDto({
    required this.titulo,
    required this.descricao,
    required this.categoria,
  });

  Map<String, dynamic> toJson() => {
    'titulo': titulo,
    'descricao': descricao,
    // O backend espera o índice do enum (0 para Bug, 1 para Duvida, etc.)
    'categoria': categoria.index,
  };
}
