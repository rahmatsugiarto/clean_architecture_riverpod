// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class MovieResponse extends Equatable {
  String? title;
  String? year;
  String? runtime;
  String? poster;

  MovieResponse({
    this.title,
    this.year,
    this.runtime,
    this.poster,
  });

  MovieResponse.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    year = json['Year'];
    runtime = json['Runtime'];
    poster = json['Poster'];
  }

  @override
  List<Object?> get props => [title, year, runtime, poster];
}
