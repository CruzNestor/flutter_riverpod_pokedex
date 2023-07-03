// ignore_for_file: constant_identifier_names
import 'package:dio/dio.dart';

const String CONNECTION_FAILURE_MESSAGE = 'Not internet connection';
const String SERVER_FAILURE_MESSAGE = 'Error server';

class ServerException implements Exception {
  const ServerException({required this.message});
  final String message;
}

String getMessageDioException(DioException e) {
  String? message;
  if (e.response != null) {
    message = e.response!.statusMessage;
  } else {
    message = e.message;
  }
  return message ?? 'Unexpect error';
}