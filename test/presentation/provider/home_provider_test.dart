import 'package:clean_architecture_riverpod/common/error/failure_response.dart';
import 'package:clean_architecture_riverpod/common/state/view_data_state.dart';
import 'package:clean_architecture_riverpod/domain/repositories/repository.dart';
import 'package:clean_architecture_riverpod/presentation/provider/home_provider.dart';
import 'package:clean_architecture_riverpod/presentation/provider/home_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import '../../dummy_data/dummy_object.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  late MockRepository mockRepository;

  setUpAll(() {
    mockRepository = MockRepository();
  });

  group(
    "fetch list movies",
    () {
      stateNotifierTest<HomeNotifier, HomeState>(
        "should get data from the repository",
        build: () => HomeNotifier(repository: mockRepository),
        setUp: () {
          when(() => mockRepository.fetchListMovies())
              .thenAnswer((_) async => Right(tListMoviesEntity));
        },
        actions: (stateNotifier) {
          stateNotifier.fetchListMovies();
        },
        verify: (_) {
          mockRepository.fetchListMovies();
        },
      );

      stateNotifierTest<HomeNotifier, HomeState>(
        "should change movies when data is gotten successfully",
        build: () => HomeNotifier(repository: mockRepository),
        setUp: () {
          when(() => mockRepository.fetchListMovies())
              .thenAnswer((_) async => Right(tListMoviesEntity));
        },
        actions: (stateNotifier) async {
          await stateNotifier.fetchListMovies();
        },
        expect: () => [
          HomeState(homeState: ViewData.loading()),
          HomeState(homeState: ViewData.loaded(data: tListMoviesEntity)),
        ],
      );

      stateNotifierTest<HomeNotifier, HomeState>(
        "should return error when data is unsuccessful",
        build: () => HomeNotifier(repository: mockRepository),
        setUp: () {
          when(() => mockRepository.fetchListMovies()).thenAnswer(
              (_) async => const Left(FailureResponse(errorMessage: '')));
        },
        actions: (stateNotifier) async {
          await stateNotifier.fetchListMovies();
        },
        expect: () => [
          HomeState(homeState: ViewData.loading()),
          HomeState(
            homeState: ViewData.error(
              message: "",
              failure: const FailureResponse(errorMessage: ''),
            ),
          ),
        ],
      );
    },
  );
}
