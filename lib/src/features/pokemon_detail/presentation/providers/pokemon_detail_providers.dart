import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../configs/providers/providers.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/repositories/pokemon_detail_repository.dart';
import '../../domain/usecases/get_pokemon_detail.dart';
import '../../infrastructure/datasources/pokemon_detail_remote_datasource.dart';
import '../../infrastructure/repositories/pokemon_detail_repository_impl.dart';
import 'controllers/get_pokemon_detail_controller.dart';


// Data source
final pokemonDetailRemoteDataSourceProvider = Provider.autoDispose<PokemonDetailRemoteDataSource>((ref){
  return PokemonDetailRemoteDataSourceImpl(httpClient: ref.read(httpClientProvider));
});

// Repository
final pokemonDetailRepositoryProvider = Provider.autoDispose<PokemonDetailRepository>((ref){
  return PokemonDetailRepositoryImpl(
    networkInfo: ref.read(networkInfoProvider),
    remote: ref.read(pokemonDetailRemoteDataSourceProvider)
  );
});

// Use cases
final getPokemonDetailProvider = Provider.autoDispose<GetPokemonDetail>((ref){
  return GetPokemonDetail(repository: ref.read(pokemonDetailRepositoryProvider));
});

// Controller Provider
final getPokemonDetailControllerProvider = StateNotifierProvider
  .autoDispose
  .family<GetPokemonDetailController, AsyncValue<PokemonDetail>, int>(
    (ref, arg) => GetPokemonDetailController(
      getPokemonDetailUseCase: ref.read(getPokemonDetailProvider),
      id: arg
    )
  );