import 'package:json_annotation/json_annotation.dart';
import 'dart:collection';
import 'package:mobile/models/comment.dart';
import 'package:mobile/models/like.dart';

part 'post.g.dart';


enum CategoriaPost {
  Bug,
  Duvida,
  Resolucao,
}
@JsonSerializable()
class Post {
  int? id;
  String? titulo;
  String? descricao;
  int? usuarioId;
  DateTime? atualizado_em;
  DateTime? criado_em;
  Set<Comment>? comentarios = HashSet<Comment>();
  Set<Like>? curtidas = HashSet<Like>();
  CategoriaPost? categoria;

  Post(this.id, this.titulo, this.descricao, this.usuarioId, this.comentarios, this.curtidas);
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}