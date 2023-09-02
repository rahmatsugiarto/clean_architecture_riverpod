import 'package:dio/dio.dart';

import '../../../common/constants/app_constants.dart';
import '../../models/response/movies_response.dart';

abstract class RemoteDataSource {
  Future<List<MovieResponse>> fetchListMovies();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;

  const RemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MovieResponse>> fetchListMovies() async {
    try {
      final response = await dio.get(AppConstants.appApi.listMovie);
      return (response.data as List)
          .map((data) => MovieResponse.fromJson(data))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
