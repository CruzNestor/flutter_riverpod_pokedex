import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../configs/providers/providers.dart';
import '../../domain/entities/searched_pokemon.dart';
import '../../domain/repositories/search_pokemon_repository.dart';
import '../../domain/usecases/search_pokemon.dart';
import '../../infrastructure/datasources/search_pokemon_remote_datasource.dart';
import '../../infrastructure/repositories/search_pokemon_repository_impl.dart';

import 'controllers/search_pokemon_controller.dart';


//Data source
final searchPokemonRemoteDataSourceProvider = Provider.autoDispose<SearchPokemonRemoteDataSource>((ref){
  return SearchPokemonRemoteDataSourceImpl(httpClient: ref.read(httpClientProvider));
});

// Repository
final searchPokemonRepositoryProvider = Provider.autoDispose<SearchPokemonRepository>((ref){
  return SearchPokemonRepositoryImpl(
    networkInfo: ref.read(networkInfoProvider),
    remote: ref.read(searchPokemonRemoteDataSourceProvider)
  );
});

// Use cases
final searchPokemonProvider = Provider.autoDispose<SearchPokemon>((ref){
  return SearchPokemon(repository: ref.read(searchPokemonRepositoryProvider));
});

// Notifier
final searchPokemonControllerProvider = StateNotifierProvider
  .autoDispose
  <SearchPokemonController, AsyncValue<SearchedPokemon?>>(
    (ref) => SearchPokemonController(
      searchPokemonUseCase: ref.read(searchPokemonProvider),
    )
  );