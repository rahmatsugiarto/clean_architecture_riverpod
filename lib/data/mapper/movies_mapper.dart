import '../../domain/entities/movie_entity.dart';
import '../models/response/movies_response.dart';

class MovieMapper {
  List<MovieEntity> mapListMoviesResToEntity(
    List<MovieResponse>? response,
  ) {
    final buildings = <MovieEntity>[];
    for (MovieResponse i in response ?? []) {
      buildings.add(mapMovieResToEntity(i));
    }
    return buildings;
  }

  MovieEntity mapMovieResToEntity(MovieResponse? res) {
    return MovieEntity(
      title: res?.title ?? "",
      year: res?.year ?? "",
      runtime: res?.runtime ?? "",
      poster: res?.poster ?? "",
    );
  }
}
