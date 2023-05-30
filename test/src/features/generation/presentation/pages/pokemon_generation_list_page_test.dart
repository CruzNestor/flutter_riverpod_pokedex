import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:pokemon_generations/src/features/generation/domain/entities/generation.dart';
import 'package:pokemon_generations/src/features/generation/domain/repositories/generation_repository.dart';
import 'package:pokemon_generations/src/features/generation/domain/usecases/get_generation.dart';
import 'package:pokemon_generations/src/features/generation/presentation/pages/pokemon_generation_list_page.dart';
import 'package:pokemon_generations/src/features/generation/presentation/providers/controllers/get_generation_controller.dart';
import 'package:pokemon_generations/src/features/generation/presentation/providers/generation_providers.dart';
import 'package:pokemon_generations/src/l10n/app_localizations.dart';

import '../../../../../fixtures/fixture_reader.dart';


class FakeRepository implements GenerationRepository {
  @override
  Future<Generation> getGeneration(int id) async {
    if(id > 0){
      return Generation.fromJson(json.decode(fixture('generation.json')));
    }
    Error.throwWithStackTrace('error', StackTrace.current);
  }
}

Widget isEvenTestWidget(
  AutoDisposeStateNotifierProviderFamily<GetGenerationController, AsyncValue<Generation>, int> mockProvider,
  int generationId
  ) {
  return ProviderScope(
    overrides: [
      getGenerationControllerProvider.overrideWithProvider(mockProvider),
    ],
    child: MaterialApp(
      home: PokemonGenerationListPage(id: generationId),
      localizationsDelegates: S.localizationsDelegates,
      supportedLocales: S.supportedLocales,
    ),
  );
}

void main() {

  group('PokemonGenerationListPage', () {

    // use case provider
    final getGenerationProvider = Provider.autoDispose<GetGeneration>((ref){
      return GetGeneration(repository: FakeRepository());
    });

    // state notifier provider
    final mockGetGenerationProvider =
    AutoDisposeStateNotifierProviderFamily<GetGenerationController, AsyncValue<Generation>, int>(
      (ref, arg) => GetGenerationController(
        getGenerationUseCase: ref.read(getGenerationProvider),
        id: arg
      )
    );

    testWidgets('the first state should be loading and second state should be data', (tester) async {
      const int tGenerationId = 1;

      await mockNetworkImagesFor(
        () => tester.pumpWidget(isEvenTestWidget(mockGetGenerationProvider, tGenerationId))
      );

      // The first frame is a loading state.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Re-render. getGenerationProvider should have finished fetching now.
      await tester.pump();

      // No longer loading
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Rendered gridview with the data returned by FakeRepository.
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('the first state should be loading and second state should be error', (tester) async {
      const int tGenerationId = 0;

      await tester.pumpWidget(isEvenTestWidget(mockGetGenerationProvider, tGenerationId));

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