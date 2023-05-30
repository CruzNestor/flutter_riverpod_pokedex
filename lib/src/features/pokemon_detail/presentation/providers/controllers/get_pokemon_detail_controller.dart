import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/pokemon_detail.dart';
import '../../../domain/usecases/get_pokemon_detail.dart';


// Controller
class GetPokemonDetailController extends StateNotifier<AsyncValue<PokemonDetail>>{

  GetPokemonDetailController({
    required GetPokemonDetail getPokemonDetailUseCase,
    required int id
  }) : super(const AsyncLoading()){
    _getPokemonDetailUseCase = getPokemonDetailUseCase;
    _id = id;
    getPokemonDetail();
  }

  late GetPokemonDetail _getPokemonDetailUseCase;
  late int _id;

  Future<void> getPokemonDetail() async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async => await _getPokemonDetailUseCase(_id));
    if (mounted) state = result;
  }
  
}