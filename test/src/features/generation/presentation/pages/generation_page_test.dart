import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:pokemon_generations/src/features/generation/presentation/pages/generation_page.dart';
import 'package:pokemon_generations/src/l10n/app_localizations.dart';


void main() {

  group('GenerationPage', () {

    testWidgets('show list of generations', (tester) async {

      await tester.pumpWidget(
        const MaterialApp(
          home: GenerationPage(),
          localizationsDelegates: S.localizationsDelegates,
          supportedLocales: S.supportedLocales,
        ),
      );

      // The first frame is a loading state.
      expect(find.byType(GridView), findsOneWidget);
    });

  });
}