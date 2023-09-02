import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../common/constants/app_constants.dart';
import '../../common/error/failure_response.dart';
import '../../common/utils/extension.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/repository.dart';
import '../datasources/remote/remote_datasource.dart';
import '../mapper/movies_mapper.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;

  RepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<FailureResponse, List<MovieEntity>>> fetchListMovies() async {
    try {
      final response = await remoteDataSource.fetchListMovies();
      final mapper = MovieMapper();
      return Right(mapper.mapListMoviesResToEntity(response));
    } on DioException catch (error) {
      if (error.isNoConnectionError) {
        return Left(
          ConnectionFailure(AppConstants.errorMessage.noInternet),
        );
      }
      return Left(
        ServerFailure(AppConstants.errorMessage.errorCommon),
      );
    } catch (e) {
      return Left(
        FailureResponse(errorMessage: AppConstants.errorMessage.errorCommon),
      );
    }
  }
}
