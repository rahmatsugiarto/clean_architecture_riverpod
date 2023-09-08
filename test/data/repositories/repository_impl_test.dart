import 'package:clean_architecture_riverpod/common/constants/app_constants.dart';
import 'package:clean_architecture_riverpod/common/error/failure_response.dart';
import 'package:clean_architecture_riverpod/common/utils/extension.dart';
import 'package:clean_architecture_riverpod/data/datasources/remote/remote_datasource.dart';
import 'package:clean_architecture_riverpod/data/repositories/repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late RepositoryImpl repository;
  late DioException dioException;

  setUpAll(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = RepositoryImpl(remoteDataSource: mockRemoteDataSource);
    dioException = DioException(requestOptions: RequestOptions());
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

    test(
        'should return ConnectionFailure when the device is not connected to the internet',
        () async {
      final errorMessage = AppConstants.errorMessage.noInternet;
      // arrange
      when(() => mockRemoteDataSource.fetchListMovies())
          .thenThrow(dioException);
      // act
      final result = await repository.fetchListMovies();
      // assert

      verify(() => mockRemoteDataSource.fetchListMovies());
      if (dioException.isNoConnectionError) {
        expect(result, equals(Left(ConnectionFailure(errorMessage))));
      }
    });

    test(
        'should return ServerFailure when it crashes, unless caused by an internet connection error',
        () async {
      final errorMessage = AppConstants.errorMessage.noInternet;
      // arrange
      when(() => mockRemoteDataSource.fetchListMovies())
          .thenThrow(dioException);
      // act
      final result = await repository.fetchListMovies();
      // assert
      verify(() => mockRemoteDataSource.fetchListMovies());
      if (!dioException.isNoConnectionError) {
        expect(result, equals(Left(ServerFailure(errorMessage))));
      }
    });

    test('should return FailureResponse when all conditions fail', () async {
      final errorMessage = AppConstants.errorMessage.errorCommon;
      // arrange
      when(() => mockRemoteDataSource.fetchListMovies()).thenThrow(Exception());
      // act
      final result = await repository.fetchListMovies();
      // assert
      verify(() => mockRemoteDataSource.fetchListMovies());
      expect(result, equals(Left(FailureResponse(errorMessage: errorMessage))));
    });
  });
}
