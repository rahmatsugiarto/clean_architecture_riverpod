import 'package:dartz/dartz.dart';

import '../../common/error/failure_response.dart';
import '../entities/movie_entity.dart';

abstract class Repository {
  Future<Either<FailureResponse, List<MovieEntity>>> fetchListMovies();
}
