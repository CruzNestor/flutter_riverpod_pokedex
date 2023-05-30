import 'package:freezed_annotation/freezed_annotation.dart';

part 'searched_pokemon.freezed.dart';
part 'searched_pokemon.g.dart';


@freezed
class SearchedPokemon with _$SearchedPokemon{
  const factory SearchedPokemon({
    required int id,
    required String name,
  }) = _SearchedPokemon;

  factory SearchedPokemon.empty() => const SearchedPokemon(id: 0, name: '');
  factory SearchedPokemon.fromJson(dynamic json) => _$SearchedPokemonFromJson(json);
}