import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import '../../../../configs/constants/http_client_constants.dart';
import '../../../../configs/errors/exceptions.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/pokemon_detail.dart';


abstract class PokemonDetailRemoteDataSource {
  Future<PokemonDetail> getPokemonDetail(int id);
}

class PokemonDetailRemoteDataSourceImpl implements PokemonDetailRemoteDataSource {

  PokemonDetailRemoteDataSourceImpl({required this.httpClient}){
    httpClient
      ..options.baseUrl = HTTPClientConstants.BASE_URL
      ..options.receiveDataWhenStatusError = true
      ..options.connectTimeout = HTTPClientConstants.CONNECT_TIMEOUT
      ..options.receiveTimeout = HTTPClientConstants.RECEIVE_TIMEOUT;
  }

  final Dio httpClient;

  @override
  Future<PokemonDetail> getPokemonDetail(int id) async {
    Response response = await httpClient.get('pokemon/$id');
    if(response.statusCode == 200){
      return PokemonDetail(
        abilities: response.data['abilities'], 
        height: response.data['height'], 
        id: response.data['id'], 
        name: response.data['name'],
        order: response.data['order'],
        species: await getSpecie(id),
        sprites: response.data['sprites'],
        stats: response.data['stats'],
        types: response.data['types'],
        weight: response.data['weight']
      );
    } else {
      throw const ServerException(message: SERVER_FAILURE_MESSAGE);
    }
  }

  Future<Map<String, dynamic>> getSpecie(int id) async {
    try {
      final locale = WidgetsBinding.instance.platformDispatcher.locale;
      const locales = S.supportedLocales;
      String flavorText = '';
      String genus = '';
      String languageCode = 'en';
      Response response = await httpClient.get('pokemon-species/$id');
      
      if(response.statusCode == 200){

        for (var element in locales) {
          if(locale.languageCode == element.languageCode){
            languageCode = locale.languageCode;
            break;
          }
        }
        
        for (var element in response.data['genera']) {
          if(element['language']['name'] == languageCode){
            genus = element['genus'];
          }
        }

        for (var element in response.data['flavor_text_entries']) {
          if(element['language']['name'] == languageCode){
            flavorText = element['flavor_text'].replaceAll('\n', ' ');
          }
        }

        return {'flavor_text' : flavorText, 'genus': genus};

      } else {
        throw const ServerException(message: SERVER_FAILURE_MESSAGE);
      }
    } on DioException catch(e) {
      if(e.response?.statusCode == 404){
        return {'flavor_text' : '', 'genus': ''};
      }
      throw const ServerException(message: SERVER_FAILURE_MESSAGE);
    }
    
  }

}