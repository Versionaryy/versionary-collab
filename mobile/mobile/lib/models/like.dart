import 'package:json_annotation/json_annotation.dart';
import 'package:mobile/models/post.dart';

part 'like.g.dart';

@JsonSerializable()
class Like {
  int? id;
  Post? post;
  int? usuarioId;
  DateTime? createdAt;

    Like(this.id, this.post, this.usuarioId, this.createdAt);
  factory Like.fromJson(Map<String, dynamic> json) => _$LikeFromJson(json);
  Map<String, dynamic> toJson() => _$LikeToJson(this);
}