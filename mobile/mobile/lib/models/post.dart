import 'package:json_annotation/json_annotation.dart';
import 'dart:collection';
import 'package:mobile/models/comment.dart';
import 'package:mobile/models/like.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  int? id;
  String? titulo;
  String? descricao;
  int? usuario_id;
  Set<Comment>? comentarios = HashSet<Comment>();
  Set<Like>? curtidas = HashSet<Like>();

  Post(this.id, this.titulo, this.descricao, this.usuario_id, this.comentarios, this.curtidas);
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}