import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_generations/src/configs/errors/exceptions.dart';
import 'package:pokemon_generations/src/configs/platform/network_info.dart';
import 'package:pokemon_generations/src/features/search_pokemon/domain/entities/searched_pokemon.dart';
import 'package:pokemon_generations/src/features/search_pokemon/infrastructure/datasources/search_pokemon_remote_datasource.dart';
import 'package:pokemon_generations/src/features/search_pokemon/infrastructure/repositories/search_pokemon_repository_impl.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockSearchPokemonRemoteDataSource extends Mock implements SearchPokemonRemoteDataSource {}


void main() {
  late SearchPokemonRepositoryImpl tRepository;
  late MockNetworkInfo mockNetworkInfo;
  late MockSearchPokemonRemoteDataSource mockRemote;

  setUp((){
    mockNetworkInfo = MockNetworkInfo();
    mockRemote = MockSearchPokemonRemoteDataSource();
    tRepository = SearchPokemonRepositoryImpl(networkInfo: mockNetworkInfo, remote: mockRemote);
  });

  group('Device is offline', () {
    const String tSearchText = 'bulbasaur';

    setUp((){
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    test("Should show a message when device isn't connect", () async {
      try {
        await tRepository.searchPokemon(tSearchText);
      } catch (e) {
        expect(e, equals(CONNECTION_FAILURE_MESSAGE));
      }
    });

  });

  group('Device is online', () {
    const String tSearchText = 'bulbasaur';
    final tSearchedPokemonModel = SearchedPokemon.fromJson(
      json.decode(fixture('searched_pokemon.json'))
    );
    
    setUp((){
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should return a model when the call to the remote data source is successful', () async {
      when(() => mockRemote.searchPokemon(tSearchText))
      .thenAnswer((_) async => Future.value(tSearchedPokemonModel));

      final result = await tRepository.searchPokemon(tSearchText);

      verify(() => mockRemote.searchPokemon(tSearchText));
      expect(result, equals(tSearchedPokemonModel));
    });

    test('should throw exception when the call to the remote data source is unsuccessful', () async {
      when(() => mockRemote.searchPokemon(tSearchText))
      .thenThrow(const ServerException(message: 'error'));

      try {
        await tRepository.searchPokemon(tSearchText);
      } on ServerException catch (e) {
        expect('error', e.message);
      }
    });

  });
  
}