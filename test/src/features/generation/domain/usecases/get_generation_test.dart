import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_generations/src/features/generation/domain/entities/generation.dart';
import 'package:pokemon_generations/src/features/generation/domain/repositories/generation_repository.dart';
import 'package:pokemon_generations/src/features/generation/domain/usecases/get_generation.dart';

import '../../../../../fixtures/fixture_reader.dart';


class MockGenerationRepository extends Mock implements GenerationRepository {}

void main() {
  late GetGeneration usecase;
  late MockGenerationRepository mockRepository;

  setUp((){
    mockRepository = MockGenerationRepository();
    usecase = GetGeneration(repository: mockRepository);
  });

  test('Should return a instance of Generation', () async {
    const int tGenerationId = 1;
    final tGenerationModel = Generation.fromJson(
      json.decode(fixture('generation.json'))
    );

    when(() => mockRepository.getGeneration(tGenerationId))
    .thenAnswer((_) async {
      return tGenerationModel;
    });

    final result = await usecase(tGenerationId);

    expect(result, tGenerationModel);
    verify(() => mockRepository.getGeneration(tGenerationId));
    verifyNoMoreInteractions(mockRepository);
  });
} 