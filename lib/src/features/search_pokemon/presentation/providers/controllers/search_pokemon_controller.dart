import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/searched_pokemon.dart';
import '../../../domain/usecases/search_pokemon.dart';


class SearchPokemonController extends StateNotifier<AsyncValue<SearchedPokemon?>>{

  SearchPokemonController({
    required SearchPokemon searchPokemonUseCase,
  }) : super(const AsyncValue.data(null)){
    _searchPokemonUseCase = searchPokemonUseCase;
  }

  late SearchPokemon _searchPokemonUseCase;

  Future<void> searchPokemon(String text) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async => await _searchPokemonUseCase(text));
    if(mounted) state = result;
  }
}