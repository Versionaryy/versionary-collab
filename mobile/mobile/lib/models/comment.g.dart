// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
  (json['id'] as num?)?.toInt(),
  json['content'] as String?,
  json['post'] == null
      ? null
      : Post.fromJson(json['post'] as Map<String, dynamic>),
  (json['userId'] as num?)?.toInt(),
  json['comentarioPai'] == null
      ? null
      : Comment.fromJson(json['comentarioPai'] as Map<String, dynamic>),
  (json['respostas'] as List<dynamic>)
      .map((e) => Comment.fromJson(e as Map<String, dynamic>))
      .toSet(),
  json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
  'id': instance.id,
  'content': instance.content,
  'post': instance.post,
  'userId': instance.userId,
  'comentarioPai': instance.comentarioPai,
  'respostas': instance.respostas.toList(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
