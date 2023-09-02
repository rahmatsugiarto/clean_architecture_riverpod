import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_constants.dart';
import '../dio_handler.dart';

final networkServiceProvider = Provider<Dio>(
  (ref) {
    return DioHandler(apiBaseUrl: AppConstants.appApi.baseUrl).dio;
  },
);
