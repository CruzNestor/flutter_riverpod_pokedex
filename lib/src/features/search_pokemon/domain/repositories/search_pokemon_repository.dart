import '../entities/searched_pokemon.dart';


abstract class SearchPokemonRepository{
  Future<SearchedPokemon> searchPokemon(String text);
}