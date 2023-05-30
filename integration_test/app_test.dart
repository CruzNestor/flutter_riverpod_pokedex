import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:pokemon_generations/main.dart' as app;


extension on WidgetTester {
  Future<void> pumpSettleApp() async {
    app.main();
    await pumpAndSettle(const Duration(seconds: 2));
  }

  Future<void> pressGenerationCard(String key) async {
    await tap(find.byKey(Key(key)));
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Generation Page', (tester) async {
    await tester.pumpSettleApp();
    // Verify if exist GridView'
    expect(find.byType(GridView), findsOneWidget);

    // Press next card generation I and verify if exist bulbasaur'
    await tester.pressGenerationCard('gen1');
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('BULBASAUR'), findsOneWidget);
  });

  testWidgets('Pokemon Detail', (tester) async {
    await tester.pumpSettleApp();

    // Verify if exist GridView'
    expect(find.byType(GridView), findsOneWidget);

    // Press next card generation I
    await tester.pressGenerationCard('gen1');
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Press element 1 from GridView
    await tester.tap(find.text('#1'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Expect the CustomScrollWidget and name of first pokemon
    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(find.text('BULBASAUR'), findsOneWidget);

    // Press back button
    await tester.tap(find.byKey(const Key('backButton')));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Should show a Gridview
    expect(find.byType(GridView), findsOneWidget);      
  });

  testWidgets('Search Pokemon', (tester) async {
    await tester.pumpSettleApp();

    // Press Search button
    await tester.tap(find.byTooltip('Search'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Should show a TextField
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(Card), findsNothing);
    
    // Enter text in search field
    await tester.enterText(find.byType(TextField), 'pikachu');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Should show the pokemon card
    expect(find.byType(Card), findsOneWidget);

    // Press card of pokemon and expect CustomScrollView
    await tester.tap(find.byType(Card));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Should show a CustomScrollView
    expect(find.byType(CustomScrollView), findsOneWidget);
    
    // Press back button
    await tester.tap(find.byKey(const Key('backButton')));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Should still show the pokemon card
    expect(find.byType(Card), findsOneWidget);

    // Press back button
    await tester.tap(find.byKey(const Key('backButton')));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Should still show the GridView
    expect(find.byType(GridView), findsOneWidget);
  });
}