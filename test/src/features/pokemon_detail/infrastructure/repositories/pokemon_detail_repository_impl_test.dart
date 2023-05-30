import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_generations/src/configs/errors/exceptions.dart';
import 'package:pokemon_generations/src/configs/platform/network_info.dart';
import 'package:pokemon_generations/src/features/pokemon_detail/domain/entities/pokemon_detail.dart';
import 'package:pokemon_generations/src/features/pokemon_detail/infrastructure/datasources/pokemon_detail_remote_datasource.dart';
import 'package:pokemon_generations/src/features/pokemon_detail/infrastructure/repositories/pokemon_detail_repository_impl.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockPokemonDetailRemoteDataSource extends Mock implements PokemonDetailRemoteDataSource {}


void main() {
  late PokemonDetailRepositoryImpl tRepository;
  late MockNetworkInfo mockNetworkInfo;
  late MockPokemonDetailRemoteDataSource mockRemote;

  setUpAll((){
    mockNetworkInfo = MockNetworkInfo();
    mockRemote = MockPokemonDetailRemoteDataSource();
    tRepository = PokemonDetailRepositoryImpl(networkInfo: mockNetworkInfo, remote: mockRemote);
  });

  group('Device is offline', () {
    const int tPokemonId = 1;

    setUp((){
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    test("Should show a message when device isn't connect", () async {
      try {
        await tRepository.getPokemonDetail(tPokemonId);
      } catch (e) {
        expect(e, equals(CONNECTION_FAILURE_MESSAGE));
      }
    });
    
  });

  group('Device is online', () {
    const int tPokemonId = 1;
    final tPokemonDetailModel = PokemonDetail.fromJson(
      json.decode(fixture('pokemon_detail.json'))
    );
    
    setUp((){
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should return a model when the call to the remote data source is successful', () async {
      when(() => mockRemote.getPokemonDetail(tPokemonId))
      .thenAnswer((_) async => Future.value(tPokemonDetailModel));

      final result = await tRepository.getPokemonDetail(tPokemonId);

      verify(() => mockRemote.getPokemonDetail(tPokemonId));
      expect(result, equals(tPokemonDetailModel));
    });

    test('should throw exception when the call to the remote data source is unsuccessful', () async {
      when(() => mockRemote.getPokemonDetail(tPokemonId))
      .thenThrow(const ServerException(message: 'error'));
      try {
        await tRepository.getPokemonDetail(tPokemonId);
      } on ServerException catch (e) {
        expect('error', e.message);
      }
    });

  });
  
}