import 'package:dio/dio.dart';

import '../../../../configs/constants/http_client_constants.dart';
import '../../domain/entities/searched_pokemon.dart';


abstract class SearchPokemonRemoteDataSource{
  Future<SearchedPokemon> searchPokemon(String text);
}

class SearchPokemonRemoteDataSourceImpl extends SearchPokemonRemoteDataSource {

  SearchPokemonRemoteDataSourceImpl({required this.httpClient}){
    httpClient
      ..options.baseUrl = HTTPClientConstants.BASE_URL
      ..options.receiveDataWhenStatusError = true
      ..options.connectTimeout = HTTPClientConstants.CONNECT_TIMEOUT
      ..options.receiveTimeout = HTTPClientConstants.RECEIVE_TIMEOUT;
  }

  final Dio httpClient;

  @override
  Future<SearchedPokemon> searchPokemon(String text) async {
    final response = await httpClient.get('pokemon/$text');
    return SearchedPokemon.fromJson(response.data);
  }
}