import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:pokemon_generations/src/features/search_pokemon/domain/entities/searched_pokemon.dart';
import 'package:pokemon_generations/src/features/search_pokemon/domain/repositories/search_pokemon_repository.dart';
import 'package:pokemon_generations/src/features/search_pokemon/domain/usecases/search_pokemon.dart';
import 'package:pokemon_generations/src/features/search_pokemon/presentation/pages/search_pokemon_page.dart';
import 'package:pokemon_generations/src/features/search_pokemon/presentation/providers/controllers/search_pokemon_controller.dart';
import 'package:pokemon_generations/src/features/search_pokemon/presentation/providers/search_pokemon_providers.dart';
import 'package:pokemon_generations/src/l10n/app_localizations.dart';

import '../../../../../fixtures/fixture_reader.dart';


class FakeRepository implements SearchPokemonRepository {
  @override
  Future<SearchedPokemon> searchPokemon(String text) async {
    if(text != ''){
      return SearchedPokemon.fromJson(json.decode(fixture('searched_pokemon.json')));
    }
    Error.throwWithStackTrace('error', StackTrace.current);
  }
}

Widget isEvenTestWidget(SearchPokemonController mockProvider) {
  return ProviderScope(
    overrides: [
      searchPokemonControllerProvider.overrideWith((ref) => mockProvider)
    ],
    child: const MaterialApp(
      home: SearchPokemonPage(),
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
    )
  );
}

void main() {

  group('SearchPokemonPage', () {

    // state notifier provider
    final mockSearchPokemonProvider = SearchPokemonController(
      searchPokemonUseCase: SearchPokemon(repository: FakeRepository()),
    );

    testWidgets('the first state should be data/null and second should be data with values', (tester) async {
      const String tSearchText = 'bulbasaur';
      
      await tester.pumpWidget(isEvenTestWidget(mockSearchPokemonProvider));
    
      // The first frame is a data state but null.
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Write in search field
      await tester.enterText(find.byType(TextField), tSearchText);
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // Re-render. mockSearchPokemonProvider should have finished fetching now.
      await mockNetworkImagesFor(
        () => tester.pump()
      );

      // Rendered Card with the data returned by FakeRepository.
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('the first state should be data/null and second state should be error', (tester) async {
      const String tSearchText = '';

      await tester.pumpWidget(isEvenTestWidget(mockSearchPokemonProvider));

      // The first frame is a data state nut null.
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Write in search field
      await tester.enterText(find.byType(TextField), tSearchText);
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // Re-render. mockSearchPokemonProvider should have finished fetching now
      await tester.pump();

      // Rendered error widget with the message
      expect(find.text('error'), findsOneWidget);
    });

  });
}