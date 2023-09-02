import 'package:dio/dio.dart';

import 'api_interceptors.dart';

class DioHandler {
  final String apiBaseUrl;

  DioHandler({
    required this.apiBaseUrl,
  });

  Dio get dio => _getDio();

  Dio _getDio() {
    BaseOptions options = BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
    );
    final dio = Dio(options);
    dio.interceptors.add(ApiInterceptors());

    return dio;
  }
}
