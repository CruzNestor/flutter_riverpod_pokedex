import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../configs/providers/providers.dart';
import '../../domain/entities/generation.dart';
import '../../domain/repositories/generation_repository.dart';
import '../../domain/usecases/get_generation.dart';
import '../../infrastructure/datasources/generation_remote_datasource.dart';
import '../../infrastructure/repositories/generation_repository_impl.dart';

import 'controllers/get_generation_controller.dart';


// Data source
final generationRemoteDataSourceProvider = Provider.autoDispose<GenerationRemoteDataSource>((ref){
  return GenerationRemoteDataSourceImpl(httpClient: ref.read(httpClientProvider));
});

// Repository
final generationRepositoryProvider = Provider.autoDispose<GenerationRepository>((ref){
  return GenerationRepositoryImpl(
    networkInfo: ref.read(networkInfoProvider),
    remote: ref.read(generationRemoteDataSourceProvider)
  );
});

// Use cases
final getGenerationProvider = Provider.autoDispose<GetGeneration>((ref){
  return GetGeneration(repository: ref.read(generationRepositoryProvider));
});

final getGenerationControllerProvider = StateNotifierProvider
  .autoDispose
  .family<GetGenerationController, AsyncValue<Generation>, int>((ref, arg){
    return GetGenerationController(
      getGenerationUseCase: ref.read(getGenerationProvider),
      id: arg
    );
  });