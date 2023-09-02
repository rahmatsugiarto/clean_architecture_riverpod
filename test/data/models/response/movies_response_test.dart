import 'dart:convert';

import 'package:clean_architecture_riverpod/data/models/response/movies_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../json_reader.dart';

void main() {
  test('should return a valid model from JSON', () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('dummy_data/movie.json'));
    // act
    final result = MovieResponse.fromJson(jsonMap);
    // assert
    expect(result, tMovieResponse);
  });
}
