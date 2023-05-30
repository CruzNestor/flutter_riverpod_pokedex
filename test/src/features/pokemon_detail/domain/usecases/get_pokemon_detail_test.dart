import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_generations/src/features/pokemon_detail/domain/entities/pokemon_detail.dart';
import 'package:pokemon_generations/src/features/pokemon_detail/domain/repositories/pokemon_detail_repository.dart';
import 'package:pokemon_generations/src/features/pokemon_detail/domain/usecases/get_pokemon_detail.dart';

import '../../../../../fixtures/fixture_reader.dart';


class MockPokemonDetailRepository extends Mock implements PokemonDetailRepository {}

void main() {
  late GetPokemonDetail usecase;
  late MockPokemonDetailRepository mockRepository;

  setUp((){
    mockRepository = MockPokemonDetailRepository();
    usecase = GetPokemonDetail(repository: mockRepository);
  });

  test('Should return a instance of PokemonDetail', () async {
    const int tPokemonId = 1;
    final tPokemonDetailModel = PokemonDetail.fromJson(
      json.decode(fixture('pokemon_detail.json'))
    );

    when(() => mockRepository.getPokemonDetail(tPokemonId))
    .thenAnswer((_) async {
      return tPokemonDetailModel;
    });

    final result = await usecase(tPokemonId);

    expect(result, tPokemonDetailModel);
    verify(() => mockRepository.getPokemonDetail(tPokemonId));
    verifyNoMoreInteractions(mockRepository);
  });
  
} 