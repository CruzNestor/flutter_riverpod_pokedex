import 'package:dio/dio.dart';
import '../../../../configs/errors/exceptions.dart';
import '../../../../configs/platform/network_info.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/repositories/pokemon_detail_repository.dart';
import '../datasources/pokemon_detail_remote_datasource.dart';


class PokemonDetailRepositoryImpl implements PokemonDetailRepository {
  PokemonDetailRepositoryImpl({
    required this.networkInfo,
    required this.remote
  });
  final NetworkInfo networkInfo;
  final PokemonDetailRemoteDataSource remote;

  @override
  Future<PokemonDetail> getPokemonDetail(int id) async {
    if(await networkInfo.isConnected){
      try {
        return await remote.getPokemonDetail(id);
      } on DioException catch(e) {
        Error.throwWithStackTrace(getMessageDioException(e), StackTrace.current);
      } on ServerException catch(e) {
        Error.throwWithStackTrace(e, StackTrace.current);
      }
    }
    Error.throwWithStackTrace(CONNECTION_FAILURE_MESSAGE, StackTrace.current);
  }

}