import 'package:clean_architecture_riverpod/data/datasources/remote/remote_datasource.dart';
import 'package:clean_architecture_riverpod/data/repositories/repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late RepositoryImpl repository;

  setUpAll(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = RepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group("fetchListMovies", () {
    test("should return movie list when call to data source is success",
        () async {
      // arrange
      when(() => mockRemoteDataSource.fetchListMovies())
          .thenAnswer((_) async => tListMoviesResponse);
      // act
      final result = await repository.fetchListMovies();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tListMoviesEntity);
    });
  });
}
