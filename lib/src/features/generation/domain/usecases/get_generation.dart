import '../../../../configs/usecases/usecase.dart';
import '../entities/generation.dart';
import '../repositories/generation_repository.dart';


class GetGeneration implements UseCase<Generation, int> {
  const GetGeneration({required this.repository});
  final GenerationRepository repository;

  @override
  Future<Generation> call(int id) async {
    return await repository.getGeneration(id);
  }
}