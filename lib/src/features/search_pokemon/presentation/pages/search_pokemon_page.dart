import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../configs/constants/http_client_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/searched_pokemon.dart';
import '../providers/search_pokemon_providers.dart';

part '../widgets/search_pokemon_widgets.dart';


class SearchPokemonPage extends ConsumerStatefulWidget {
  const SearchPokemonPage({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPokemonPageState();
}

class _SearchPokemonPageState extends ConsumerState<SearchPokemonPage> {

  final _searchEditingController = TextEditingController();

  @override
  void dispose() {
    _searchEditingController.dispose();
    super.dispose();
  }

  void searchPokemon(WidgetRef ref, String text) async {
    final provider = ref.read(searchPokemonControllerProvider.notifier);
    await provider.searchPokemon(text.toLowerCase().trim());
  }

  @override
  Widget build(BuildContext context) {
    final stateNotifier = ref.watch(searchPokemonControllerProvider);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 56.0,
        toolbarHeight: 56.0,
        elevation: 1,
        leading: IconButton(
          key: const Key('backButton'),
          onPressed: () => Navigator.of(context).pop(),
          iconSize: 24.0,
          icon: const Icon(Icons.arrow_back)
        ),
        title: Container(
          alignment: Alignment.center,
          height: 56.0,
          child: TextField(
            autofocus: true,
            controller: _searchEditingController,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration.collapsed(
              hintText: S.of(context).searchPokemonPlaceholder
            ),
            onSubmitted: (text) => searchPokemon(ref, text)
          )
        ),
        titleSpacing: 0.0,
        actions: [
          Container(
            alignment: Alignment.center,
            width: 56.0,
            height: 56.0,
            child: IconButton(
              onPressed: () => _searchEditingController.text = '',
              iconSize: 24.0,
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.clear)
            )
          )
        ]
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: LayoutBuilder(
          builder: (_, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: stateNotifier.when(
                data: (data) {
                  if(data == null){
                    return const SizedBox();
                  }
                  return buildPokemonImage(context, data, onTap: () {
                    context.push('/pokemon/${data.id}');
                  });
                },
                error: (error, stackTrace) {
                  return messageWidget(child: Text('$error'));
                }, 
                loading: () {
                  return messageWidget(child: const CircularProgressIndicator());
                }
              )
            )
          )
        )
      )
    );
  }

}