import '../../../../configs/usecases/usecase.dart';
import '../entities/pokemon_detail.dart';
import '../repositories/pokemon_detail_repository.dart';


class GetPokemonDetail implements UseCase<PokemonDetail, int> {
  const GetPokemonDetail({required this.repository});
  final PokemonDetailRepository repository;

  @override
  Future<PokemonDetail> call(int id) async {
    return await repository.getPokemonDetail(id);
  }
}