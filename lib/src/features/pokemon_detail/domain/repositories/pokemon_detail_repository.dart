import '../entities/pokemon_detail.dart';


abstract class PokemonDetailRepository {
  Future<PokemonDetail> getPokemonDetail(int id);
}