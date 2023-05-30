import '../entities/generation.dart';


abstract class GenerationRepository {
  Future<Generation> getGeneration(int id);
}