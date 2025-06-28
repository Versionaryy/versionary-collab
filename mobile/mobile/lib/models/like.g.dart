// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Like _$LikeFromJson(Map<String, dynamic> json) => Like(
  (json['id'] as num?)?.toInt(),
  json['post'] == null
      ? null
      : Post.fromJson(json['post'] as Map<String, dynamic>),
  (json['usuarioId'] as num?)?.toInt(),
  json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$LikeToJson(Like instance) => <String, dynamic>{
  'id': instance.id,
  'post': instance.post,
  'usuarioId': instance.usuarioId,
  'createdAt': instance.createdAt?.toIso8601String(),
};
