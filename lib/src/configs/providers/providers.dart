import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../platform/network_info.dart';


// External
final httpClientProvider = Provider.autoDispose<Dio>((ref) => Dio());

// Config
final networkInfoProvider = Provider.autoDispose<NetworkInfo>((ref) => NetworkInfoImpl());