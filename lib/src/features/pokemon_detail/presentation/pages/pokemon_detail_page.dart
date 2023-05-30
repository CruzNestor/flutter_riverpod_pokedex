import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:sliver_tools/sliver_tools.dart';

import '../../../../configs/constants/ui_constants.dart';
import '../../../../configs/utils/converter.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../providers/pokemon_detail_providers.dart';

part '../widgets/pokemon_detail_widgets.dart';


class PokemonDetailPage extends ConsumerWidget {

  const PokemonDetailPage({required this.id, super.key});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getPokemonDetailControllerProvider(id));
    return Container(
      decoration:  BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: state.hasValue
          ? DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(UIConstants.SPACE_BACKGROUND).image,
          ) 
          : null
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(context, state),
        body: RefreshIndicator(
          onRefresh: () async {
            return await ref.refresh(getPokemonDetailControllerProvider(id));
          },
          child: state.when(
            data: (data) {
              return buildContentDetail(context, data);
            }, 
            error: (error, stackTrace) {
              return buildErrorMessage('$error');
            }, 
            loading: () {
              return buildLoading();
            }
          )
        )
      )
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context, AsyncValue stateNotifier){
    return PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: AppBar(
        elevation: 0,
        backgroundColor: stateNotifier.hasValue 
          ? Colors.transparent 
          : Theme.of(context).scaffoldBackgroundColor,
      )
    );
  }

  Widget buildContentDetail(BuildContext context, PokemonDetail poke){
    return CustomScrollView(slivers: [
      // Appbar 
      SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 14.0),
              child:  GestureDetector(
                key: const Key('backButton'),
                onTap: (){
                  context.pop();
                },
                child: ClipOval(
                  child: Container(width: 35,height: 35,
                    color: Colors.white70,
                    child: const Icon(Icons.close, color: Colors.black)
                  )
                )
              )
            ),
            const SizedBox(width: 2),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 14.0, left: 14.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(width: 65, height: 35,
                  color: Colors.white70,
                  child: Center(
                    child: Text('#${poke.id}', 
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    )
                  )
                )
              )
            )
          ]
        )
      ),

      // Content
      SliverStack(children: [
        // Card
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(top: 130, right: 14.0, bottom: 14.0, left: 14.0),
            padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8)
            ),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.7
            ),
            child: Column(children: [
              buildSectionName(poke.name),
              buildSectionWTH(context, poke.height, poke.weight, poke.types), // section weight, type and height
              titleHeader(S.of(context).baseStats.toUpperCase()),
              buildSectionBaseStats(context: context, stats: poke.stats),
              titleHeader(S.of(context).abilities.toUpperCase()),
              buildSectionAbilities(poke.abilities),
              buildSectionDescription(poke.species),
            ])
          )
        ),

        // Image pokemon
        SliverPositioned(
          top: 10.0, right: 8.0, left: 8.0,
          child: buildPokemonImage(poke.sprites)
        )
      ])
    ]);
  }

  Widget buildErrorMessage(String message) {
    return Column(children: [
      Expanded(
        child: LayoutBuilder(
          builder: (context, constraints) => ListView(children: [
            Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Text(message)
            )
          ])
        )
      )
    ]);
  }

  Widget buildLoading() {
    return Column(children: const [
      Expanded(
        child: Center(child: CircularProgressIndicator())
      )
    ]);
  }

}