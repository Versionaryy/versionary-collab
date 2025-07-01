import 'package:json_annotation/json_annotation.dart';
import 'dart:collection';
import 'package:mobile/models/comment.dart';
import 'package:mobile/models/like.dart';
import 'package:mobile/models/post.dart';

part 'postFeed.g.dart';



@JsonSerializable()
class PostFeed {
  int? id;
  String? titulo;
  String? descricao;
  int? usuarioId;
  DateTime? atualizado_em;
  int totalComentarios = 0;
  CategoriaPost? categoria;

  PostFeed(this.id, this.titulo, this.descricao, this.usuarioId, this.totalComentarios);
  factory PostFeed.fromJson(Map<String, dynamic> json) => _$PostFeedFromJson(json);
  Map<String, dynamic> toJson() => _$PostFeedToJson(this);
}