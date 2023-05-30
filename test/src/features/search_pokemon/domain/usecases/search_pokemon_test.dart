import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_generations/src/features/search_pokemon/domain/entities/searched_pokemon.dart';
import 'package:pokemon_generations/src/features/search_pokemon/domain/repositories/search_pokemon_repository.dart';
import 'package:pokemon_generations/src/features/search_pokemon/domain/usecases/search_pokemon.dart';

import '../../../../../fixtures/fixture_reader.dart';


class MockSearchPokemonRepository extends Mock implements SearchPokemonRepository {}

void main() {
  late SearchPokemon usecase;
  late MockSearchPokemonRepository mockRepository;

  setUp((){
    mockRepository = MockSearchPokemonRepository();
    usecase = SearchPokemon(repository: mockRepository);
  });

  test('Should return a instance of SearchedPokemon', () async {
    const String tSearchText = 'bulbasaur';
    final tSearchedPokemonModel = SearchedPokemon.fromJson(
      json.decode(fixture('searched_pokemon.json'))
    );

    when(() => mockRepository.searchPokemon(tSearchText))
    .thenAnswer((_) async {
      return tSearchedPokemonModel;
    });

    final result = await usecase(tSearchText);

    expect(result, tSearchedPokemonModel);
    verify(() => mockRepository.searchPokemon(tSearchText));
    verifyNoMoreInteractions(mockRepository);
  });
  
} 