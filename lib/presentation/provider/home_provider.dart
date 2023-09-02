import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/state/view_data_state.dart';
import '../../domain/providers/repository_providers.dart';
import '../../domain/repositories/repository.dart';
import 'home_state.dart';

final homeProvider =
    StateNotifierProvider.autoDispose<HomeNotifier, HomeState>((ref) {
  final repository = ref.watch(repositoryProvider);
  return HomeNotifier(repository: repository)..fetchListMovies();
});

class HomeNotifier extends StateNotifier<HomeState> {
  final Repository repository;
  HomeNotifier({required this.repository})
      : super(HomeState(homeState: ViewData.initial()));

  Future<void> fetchListMovies() async {
    state = state.copyWith(homeState: ViewData.loading());

    final result = await repository.fetchListMovies();

    result.fold(
      (failure) {
        state = state.copyWith(
          homeState: ViewData.error(
            message: failure.errorMessage,
            failure: failure,
          ),
        );
      },
      (result) {
        state = state.copyWith(
          homeState: ViewData.loaded(data: result),
        );
      },
    );
  }
}
