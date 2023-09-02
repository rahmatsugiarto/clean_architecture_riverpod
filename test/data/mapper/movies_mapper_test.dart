import 'package:clean_architecture_riverpod/data/mapper/movies_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_object.dart';

void main() {
  late MovieMapper movieMapper;

  setUp(() {
    movieMapper = MovieMapper();
  });

  test("should return List<MovieEntity> from List<MovieResponse>", () {
    final listMoviesEntity =
        movieMapper.mapListMoviesResToEntity([tMovieResponse]);
    expect(listMoviesEntity, [tMovieEntity]);
  });

  test("should return MovieEntity from MovieResponse", () {
    final movieEntity = movieMapper.mapMovieResToEntity(tMovieResponse);
    expect(movieEntity, tMovieEntity);
  });
}
