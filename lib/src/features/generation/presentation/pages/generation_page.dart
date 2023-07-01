import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../../configs/constants/ui_constants.dart';
import '../../../../l10n/app_localizations.dart';


final List<Map<String, dynamic>> generations = [
  {'id': 1, 'name': 'I'},
  {'id': 2, 'name': 'II'},
  {'id': 3, 'name': 'III'},
  {'id': 4, 'name': 'IV'},
  {'id': 5, 'name': 'V'},
  {'id': 6, 'name': 'VI'},
  {'id': 7, 'name': 'VII'},
  {'id': 8, 'name': 'VIII'},
  {'id': 9, 'name': 'IX'}
];

class GenerationPage extends StatelessWidget {
  const GenerationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.6;
    final double itemWidth = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).generations),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              tooltip: 'Search',
              onPressed: () {
                context.push('/search');
              }, 
              icon: const Icon(Icons.search)),
          )
        ]
      ),
      body: GridView.count(
        childAspectRatio: itemWidth / itemHeight,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        children: List.generate(generations.length, (index) {
          return GestureDetector(
            key: Key("gen${generations[index]['id']}"),
            onTap: () {
              context.push('/generation/${generations[index]['id']}');
            },
            child: Card(
              child: AspectRatio(
                aspectRatio: itemWidth / itemHeight,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        S.of(context).generationWithNum(generations[index]['name'])
                      )
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          '${UIConstants.POKEMON_GENERATION}/${generations[index]['id']}.png'
                        )
                      )
                    )
                  ]
                )
              )
            )
          );
        })
      )
    );
  }

}