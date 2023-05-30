import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../configs/constants/http_client_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/generation.dart';
import '../providers/generation_providers.dart';

part '../widgets/pokemon_generation_list_widgets.dart';


class PokemonGenerationListPage extends ConsumerWidget {
  const PokemonGenerationListPage({required this.id, super.key});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getGenerationControllerProvider(id));
  
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(S.of(context).generationWithNum('$id')),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return await ref.refresh(getGenerationControllerProvider(id));
        },
        child: Column(
          children: [
            state.when(
              data: (data) => buildPokemonList(context, data),
              error: (error, stackTrace) => buildErrorMessage('$error'),
              loading: () => buildLoading(),
            )
          ]
        )
      )
    );
  }

  Widget buildErrorMessage(String message) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => ListView(children: [
          Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight
            ),
            child: Text(message)
          )
        ])
      )
    );
  }

  Widget buildLoading(){
    return const Expanded(
      child: Center(child: CircularProgressIndicator())
    );
  }

}