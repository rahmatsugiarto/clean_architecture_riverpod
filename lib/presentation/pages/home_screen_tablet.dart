import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/resources/strings.dart';
import '../../common/state/view_data_state.dart';
import '../../domain/entities/movie_entity.dart';
import '../provider/home_provider.dart';
import '../widgets/custom_refresh_indicator.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/no_data_view.dart';

class HomeScreenTablet extends StatefulHookConsumerWidget {
  const HomeScreenTablet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreenTablet> {
  Future<void> fetchListMovies() async {
    ref.read(homeProvider.notifier).fetchListMovies();
  }

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 3),
    );

    useEffect(() {
      animationController.forward();
      return null;
    }, const []);

    useAnimation(animationController);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.movies),
      ),
      body: Builder(builder: (context) {
        final homeState = ref.watch(homeProvider);
        final status = homeState.homeState.status;
        final listMovies = homeState.homeState.data ?? <MovieEntity>[];

        if (status.isLoading) {
          return const LoadingView();
        } else if (status.isNoData) {
          return CustomRefreshIndicator(
            onRefresh: fetchListMovies,
            noData: true,
            child: const NoDataView(),
          );
        } else if (status.isHasData) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
            ),
            padding: const EdgeInsets.all(20),
            itemCount: listMovies.length,
            itemBuilder: (context, index) {
              final movie = listMovies[index];

              return LayoutBuilder(
                builder: (context, constraints) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Strings.title),
                                Text(Strings.year),
                                Text(Strings.runtime),
                                Text(Strings.poster),
                              ],
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ": ${movie.title}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(": ${movie.year}"),
                                  Text(": ${movie.runtime}"),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(": "),
                                      Opacity(
                                        opacity: animationController.value,
                                        child: Image.network(
                                          movie.poster,
                                          height: constraints.maxHeight / 1.4,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const SizedBox.shrink();
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return CustomRefreshIndicator(
            onRefresh: fetchListMovies,
            noData: true,
            child: ErrorView(message: homeState.homeState.message),
          );
        }
      }),
    );
  }
}
