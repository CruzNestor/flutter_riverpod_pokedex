import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';

import '../../../../configs/constants/http_client_constants.dart';
import '../../../../configs/errors/exceptions.dart';
import '../../domain/entities/generation.dart';


abstract class GenerationRemoteDataSource{
  Future<Generation> getGeneration(int id);
}

class GenerationRemoteDataSourceImpl implements GenerationRemoteDataSource{

  GenerationRemoteDataSourceImpl({required this.httpClient}){
    httpClient
      ..options.baseUrl = HTTPClientConstants.BASE_URL
      ..options.receiveDataWhenStatusError = true
      ..options.connectTimeout = HTTPClientConstants.CONNECT_TIMEOUT
      ..options.receiveTimeout = HTTPClientConstants.RECEIVE_TIMEOUT;
  }

  final Dio httpClient;

  @override
  Future<Generation> getGeneration(int id) async {
    Response response = await httpClient.get('generation/$id');
    if(response.statusCode == 200){
      final generation = Generation.fromJson(response.data);
      List<dynamic> species = [...generation.pokemonSpecies];
      species.sort((a, b){
        File fileA = File(a['url']);
        int pokeIdA = int.parse(basename(fileA.path));

        File fileB = File(b['url']); 
        int pokeIdB = int.parse(basename(fileB.path));
        
        if(pokeIdA > pokeIdB){
          return 1;
        }
        return -1;
      });

      final generationSort = generation.copyWith(pokemonSpecies: species);
      return generationSort;

    } else {
      throw const ServerException(message: SERVER_FAILURE_MESSAGE);
    }
  }
}