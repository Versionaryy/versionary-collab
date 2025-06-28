import 'dart:collection';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/models/post.dart';
part 'comment.g.dart';


@JsonSerializable()
class Comment {
  int? id;
  String? content;
  Post? post;
  int? userId;
  Comment? comentarioPai;
  Set<Comment> respostas = HashSet<Comment>();
  DateTime? createdAt;
  DateTime? updatedAt;

    Comment(this.id, this.content, this.post, this.userId, this.comentarioPai, this.respostas, this.createdAt, this.updatedAt);
  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}