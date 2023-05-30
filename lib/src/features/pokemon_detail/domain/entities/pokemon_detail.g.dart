// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PokemonDetail _$$_PokemonDetailFromJson(Map<String, dynamic> json) =>
    _$_PokemonDetail(
      abilities: json['abilities'] as List<dynamic>,
      height: json['height'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      order: json['order'] as int,
      species: json['species'] as Map<String, dynamic>,
      sprites: json['sprites'] as Map<String, dynamic>,
      stats: json['stats'] as List<dynamic>,
      types: json['types'] as List<dynamic>,
      weight: json['weight'] as int,
    );

Map<String, dynamic> _$$_PokemonDetailToJson(_$_PokemonDetail instance) =>
    <String, dynamic>{
      'abilities': instance.abilities,
      'height': instance.height,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'species': instance.species,
      'sprites': instance.sprites,
      'stats': instance.stats,
      'types': instance.types,
      'weight': instance.weight,
    };
