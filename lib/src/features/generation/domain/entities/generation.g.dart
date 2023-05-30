// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Generation _$$_GenerationFromJson(Map<String, dynamic> json) =>
    _$_Generation(
      id: json['id'] as int,
      name: json['name'] as String,
      pokemonSpecies: json['pokemon_species'] as List<dynamic>,
    );

Map<String, dynamic> _$$_GenerationToJson(_$_Generation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pokemon_species': instance.pokemonSpecies,
    };
