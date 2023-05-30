import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/generation.dart';
import '../../../domain/usecases/get_generation.dart';


// Controller
class GetGenerationController extends StateNotifier<AsyncValue<Generation>> {
  GetGenerationController({
    required GetGeneration getGenerationUseCase,
    required int id
  }) : super(const AsyncLoading()){
    _getGenerationUseCase = getGenerationUseCase;
    _id = id;
    getGeneration();
  }

  late int _id;
  late GetGeneration _getGenerationUseCase;

  Future<void> getGeneration() async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async => await _getGenerationUseCase(_id));
    if(mounted) state = result;
  }
}