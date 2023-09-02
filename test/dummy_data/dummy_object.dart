import 'package:clean_architecture_riverpod/data/mapper/movies_mapper.dart';
import 'package:clean_architecture_riverpod/data/models/response/movies_response.dart';
import 'package:clean_architecture_riverpod/domain/entities/movie_entity.dart';

final tMovieResponse = MovieResponse(
  title: "The Lion King",
  year: "2019",
  runtime: "118 min",
  poster:
      "https://m.media-amazon.com/images/M/MV5BMjIwMjE1Nzc4NV5BMl5BanBnXkFtZTgwNDg4OTA1NzM@._V1_SX300.jpg",
);

const tMovieEntity = MovieEntity(
  title: "The Lion King",
  year: "2019",
  runtime: "118 min",
  poster:
      "https://m.media-amazon.com/images/M/MV5BMjIwMjE1Nzc4NV5BMl5BanBnXkFtZTgwNDg4OTA1NzM@._V1_SX300.jpg",
);

final MovieMapper productMapper = MovieMapper();

final tListMoviesEntity =
    productMapper.mapListMoviesResToEntity([tMovieResponse]);

final tListMoviesResponse = [tMovieResponse];
