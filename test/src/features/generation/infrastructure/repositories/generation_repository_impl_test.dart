import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_generations/src/configs/errors/exceptions.dart';
import 'package:pokemon_generations/src/configs/platform/network_info.dart';
import 'package:pokemon_generations/src/features/generation/domain/entities/generation.dart';
import 'package:pokemon_generations/src/features/generation/infrastructure/datasources/generation_remote_datasource.dart';
import 'package:pokemon_generations/src/features/generation/infrastructure/repositories/generation_repository_impl.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockGenerationRemoteDataSource extends Mock implements GenerationRemoteDataSource {}


void main() {
  late GenerationRepositoryImpl tRepository;
  late MockNetworkInfo mockNetworkInfo;
  late MockGenerationRemoteDataSource mockRemote;

  setUp((){
    mockNetworkInfo = MockNetworkInfo();
    mockRemote = MockGenerationRemoteDataSource();
    tRepository = GenerationRepositoryImpl(networkInfo: mockNetworkInfo, remote: mockRemote);
  });

  group('Device is offline', () {
    const int tGenerationId = 1;

    setUp((){
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    test("Should show a message when device isn't connect", () async {
      try {
        await tRepository.getGeneration(tGenerationId);
      } catch (e) {
        expect(e, equals(CONNECTION_FAILURE_MESSAGE));
      }
    });
    
  });

  group('Device is online', () {
    const int tGenerationId = 1;
    final tGenerationModel = Generation.fromJson(
      json.decode(fixture('generation.json'))
    );
    
    setUp((){
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should return a model when the call to the remote data source is successful', () async {
      when(() => mockRemote.getGeneration(tGenerationId))
      .thenAnswer((_) async => Future.value(tGenerationModel));

      final result = await tRepository.getGeneration(tGenerationId);

      verify(() => mockRemote.getGeneration(tGenerationId));
      expect(result, equals(tGenerationModel));
    });

    test('should throw exception when the call to the remote data source is unsuccessful', () async {
      when(() => mockRemote.getGeneration(tGenerationId))
      .thenThrow(const ServerException(message: 'error'));
      try {
        await tRepository.getGeneration(tGenerationId);
      } on ServerException catch (e) {
        expect('error', e.message);
      }
    });

  });
  
}