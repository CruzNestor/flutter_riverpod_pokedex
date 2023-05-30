import 'package:freezed_annotation/freezed_annotation.dart';

part 'generation.freezed.dart';
part 'generation.g.dart';


@freezed
class Generation with _$Generation{
  const factory Generation({
    required int id,
    required String name,
    @JsonKey(name: 'pokemon_species') required List<dynamic> pokemonSpecies
  }) = _Generation;

  factory Generation.empty() => const Generation(id: 0, name: '', pokemonSpecies: []);
  factory Generation.fromJson(dynamic json) => _$GenerationFromJson(json);
}