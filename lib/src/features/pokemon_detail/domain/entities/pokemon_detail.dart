import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_detail.freezed.dart';
part 'pokemon_detail.g.dart';


@freezed
class PokemonDetail with _$PokemonDetail{
  const factory PokemonDetail({
    required List<dynamic> abilities,
    required int height, // decimetres
    required int id,
    required String name,
    required int order,
    required Map<String, dynamic> species,
    required Map<String, dynamic> sprites,
    required List<dynamic> stats,
    required List<dynamic> types,
    required int weight
  }) = _PokemonDetail;

  factory PokemonDetail.empty() => const PokemonDetail(
    abilities: [],
    height: 0,
    id: 0,
    name: '',
    order: 0,
    species: {},
    sprites: {},
    stats: [],
    types: [],
    weight: 0
  );
  factory PokemonDetail.fromJson(dynamic json) => _$PokemonDetailFromJson(json);
}