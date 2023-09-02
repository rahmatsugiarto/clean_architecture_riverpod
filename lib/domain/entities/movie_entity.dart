import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String title;
  final String year;
  final String runtime;
  final String poster;

  const MovieEntity({
    this.title = "",
    this.year = "",
    this.runtime = "",
    this.poster = "",
  });

  @override
  List<Object?> get props => [title, year, runtime, poster];
}
