// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostFeed _$PostFeedFromJson(Map<String, dynamic> json) =>
    PostFeed(
        (json['id'] as num?)?.toInt(),
        json['titulo'] as String?,
        json['descricao'] as String?,
        (json['usuarioId'] as num?)?.toInt(),
        (json['totalComentarios'] as num).toInt(),
      )
      ..atualizado_em =
          json['atualizado_em'] == null
              ? null
              : DateTime.parse(json['atualizado_em'] as String)
      ..categoria = $enumDecodeNullable(
        _$CategoriaPostEnumMap,
        json['categoria'],
      );

Map<String, dynamic> _$PostFeedToJson(PostFeed instance) => <String, dynamic>{
  'id': instance.id,
  'titulo': instance.titulo,
  'descricao': instance.descricao,
  'usuarioId': instance.usuarioId,
  'atualizado_em': instance.atualizado_em?.toIso8601String(),
  'totalComentarios': instance.totalComentarios,
  'categoria': _$CategoriaPostEnumMap[instance.categoria],
};

const _$CategoriaPostEnumMap = {
  CategoriaPost.Bug: 'Bug',
  CategoriaPost.Duvida: 'Duvida',
  CategoriaPost.Resolucao: 'Resolucao',
};
