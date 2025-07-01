// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) =>
    Post(
        (json['id'] as num?)?.toInt(),
        json['titulo'] as String?,
        json['descricao'] as String?,
        (json['usuarioId'] as num?)?.toInt(),
        (json['comentarios'] as List<dynamic>?)
            ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
            .toSet(),
        (json['curtidas'] as List<dynamic>?)
            ?.map((e) => Like.fromJson(e as Map<String, dynamic>))
            .toSet(),
      )
      ..atualizado_em =
          json['atualizado_em'] == null
              ? null
              : DateTime.parse(json['atualizado_em'] as String)
      ..criado_em =
          json['criado_em'] == null
              ? null
              : DateTime.parse(json['criado_em'] as String)
      ..categoria = $enumDecodeNullable(
        _$CategoriaPostEnumMap,
        json['categoria'],
      );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
  'id': instance.id,
  'titulo': instance.titulo,
  'descricao': instance.descricao,
  'usuarioId': instance.usuarioId,
  'atualizado_em': instance.atualizado_em?.toIso8601String(),
  'criado_em': instance.criado_em?.toIso8601String(),
  'comentarios': instance.comentarios?.toList(),
  'curtidas': instance.curtidas?.toList(),
  'categoria': _$CategoriaPostEnumMap[instance.categoria],
};

const _$CategoriaPostEnumMap = {
  CategoriaPost.Bug: 'Bug',
  CategoriaPost.Duvida: 'Duvida',
  CategoriaPost.Resolucao: 'Resolucao',
};
