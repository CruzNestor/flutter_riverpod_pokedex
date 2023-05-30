import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:pokemon_generations/src/features/pokemon_detail/domain/entities/pokemon_detail.dart';
import 'package:pokemon_generations/src/features/pokemon_detail/domain/repositories/pokemon_detail_repository.dart';
import 'package:pokemon_generations/src/features/pokemon_detail/domain/usecases/get_pokemon_detail.dart';
import 'package:pokemon_generations/src/features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import 'package:pokemon_generations/src/features/pokemon_detail/presentation/providers/controllers/get_pokemon_detail_controller.dart';
import 'package:pokemon_generations/src/features/pokemon_detail/presentation/providers/pokemon_detail_providers.dart';
import 'package:pokemon_generations/src/l10n/app_localizations.dart';

import '../../../../../fixtures/fixture_reader.dart';


class FakeRepository implements PokemonDetailRepository {
  @override
  Future<PokemonDetail> getPokemonDetail(int id) async {
    if(id > 0){
      return PokemonDetail.fromJson(json.decode(fixture('pokemon_detail.json')));
    }
    Error.throwWithStackTrace('error', StackTrace.current);
  }
}

Widget isEvenTestWidget(
  AutoDisposeStateNotifierProviderFamily<GetPokemonDetailController, AsyncValue<PokemonDetail>, int> mockProvider,
  int pokemonId
  ) {
  return ProviderScope(
    overrides: [
      getPokemonDetailControllerProvider.overrideWithProvider(mockProvider)
    ],
    child: MaterialApp(
      home: PokemonDetailPage(id: pokemonId),
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
    )
  );
}

void main() {

  group('PokemonDetailPage', () {

    // use case provider
    final getPokemonDetailProvider = Provider.autoDispose<GetPokemonDetail>(
      (ref) => GetPokemonDetail(repository: FakeRepository())
    );

    // state notifier provider
    final mockPokemonDetailProvider =
    AutoDisposeStateNotifierProviderFamily<GetPokemonDetailController, AsyncValue<PokemonDetail>, int>(
      (ref, arg) => GetPokemonDetailController(
        getPokemonDetailUseCase: ref.read(getPokemonDetailProvider),
        id: arg
      )
    );

    testWidgets('the first state should be loading and second should be data', (tester) async {
      const int tPokemonId = 1;
      
      await tester.pumpWidget(isEvenTestWidget(mockPokemonDetailProvider, tPokemonId));
    
      // The first frame is a loading state.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Re-render. pokemonDetailProvider should have finished fetching now.
      await mockNetworkImagesFor(
        () => tester.pump()
      );

      // No longer loading
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Rendered CustomScrollView with the data returned by FakeRepository.
      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('the first state should be loading and second state should be error', (tester) async {
      const int tPokemonId = 0;

      await tester.pumpWidget(isEvenTestWidget(mockPokemonDetailProvider, tPokemonId));

      // The first frame is a loading state.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Re-render. getGenerationProvider should have finished fetching now
      await tester.pump();

      // No longer loading
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Rendered error widget with the message
      expect(find.text('error'), findsOneWidget);
    });

  });
}