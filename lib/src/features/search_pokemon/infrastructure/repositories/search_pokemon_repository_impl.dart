import 'package:dio/dio.dart';

import '../../../../configs/errors/exceptions.dart';
import '../../../../configs/platform/network_info.dart';
import '../../domain/entities/searched_pokemon.dart';
import '../../domain/repositories/search_pokemon_repository.dart';
import '../datasources/search_pokemon_remote_datasource.dart';


class SearchPokemonRepositoryImpl implements SearchPokemonRepository {
  SearchPokemonRepositoryImpl({
    required this.networkInfo,
    required this.remote
  });

  final NetworkInfo networkInfo;
  final SearchPokemonRemoteDataSource remote;

  @override
  Future<SearchedPokemon> searchPokemon(String text) async{
    if(await networkInfo.isConnected){
      try {
        return await remote.searchPokemon(text);
      } on DioError catch(e) {
        Error.throwWithStackTrace(
          DioException.fromDioError(e).toString(), StackTrace.current
        );
      }
    }
    Error.throwWithStackTrace(CONNECTION_FAILURE_MESSAGE, StackTrace.current);
  }
}