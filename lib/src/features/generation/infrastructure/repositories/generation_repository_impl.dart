import 'package:dio/dio.dart';

import '../../../../configs/errors/exceptions.dart';
import '../../../../configs/platform/network_info.dart';
import '../../domain/entities/generation.dart';
import '../../domain/repositories/generation_repository.dart';
import '../datasources/generation_remote_datasource.dart';


class GenerationRepositoryImpl implements GenerationRepository {

  GenerationRepositoryImpl({
    required this.networkInfo,
    required this.remote
  });

  final NetworkInfo networkInfo;
  final GenerationRemoteDataSource remote;
  
  @override
  Future<Generation> getGeneration(int id) async {
    if(await networkInfo.isConnected){
      try {
        return await remote.getGeneration(id);
      } on DioError catch(e) {
        Error.throwWithStackTrace(DioException.fromDioError(e).toString(), StackTrace.current);
      } on ServerException catch(e) {
        Error.throwWithStackTrace(e, StackTrace.current);
      }
    }
    Error.throwWithStackTrace(CONNECTION_FAILURE_MESSAGE, StackTrace.current);
  }
}