import '../../../../configs/usecases/usecase.dart';
import '../entities/searched_pokemon.dart';
import '../repositories/search_pokemon_repository.dart';


class SearchPokemon implements UseCase<SearchedPokemon, String> {
  SearchPokemon({required this.repository});
  final SearchPokemonRepository repository;
  
  @override
  Future<SearchedPokemon> call(String text) {
    return repository.searchPokemon(text);
  }
}