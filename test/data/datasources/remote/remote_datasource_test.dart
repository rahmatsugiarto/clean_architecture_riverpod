import 'package:clean_architecture_riverpod/data/datasources/remote/remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_object.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late RemoteDataSourceImpl remoteDataSourceImpl;

  setUp(() {
    mockDio = MockDio();
    remoteDataSourceImpl = RemoteDataSourceImpl(dio: mockDio);
  });

  group("fetchListMovies", () {
    test("should return list of Movie Response when success ", () async {
      // arrange
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => dio.Response(
          data: [
            {
              "Title": "The Lion King",
              "Year": "2019",
              "Runtime": "118 min",
              "Poster":
                  "https://m.media-amazon.com/images/M/MV5BMjIwMjE1Nzc4NV5BMl5BanBnXkFtZTgwNDg4OTA1NzM@._V1_SX300.jpg"
            }
          ],
          requestOptions: RequestOptions(),
        ),
      );
      // act
      final result = await remoteDataSourceImpl.fetchListMovies();
      // assert
      expect(result, equals(tListMoviesResponse));
    });
  });
}
