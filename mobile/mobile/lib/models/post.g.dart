// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
  (json['id'] as num?)?.toInt(),
  json['titulo'] as String?,
  json['descricao'] as String?,
  (json['usuario_id'] as num?)?.toInt(),
  (json['comentarios'] as List<dynamic>?)
      ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
      .toSet(),
  (json['curtidas'] as List<dynamic>?)
      ?.map((e) => Like.fromJson(e as Map<String, dynamic>))
      .toSet(),
);

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
  'id': instance.id,
  'titulo': instance.titulo,
  'descricao': instance.descricao,
  'usuario_id': instance.usuario_id,
  'comentarios': instance.comentarios?.toList(),
  'curtidas': instance.curtidas?.toList(),
};
