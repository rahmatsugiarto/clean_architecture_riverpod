import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../common/state/view_data_state.dart';
import '../../domain/entities/movie_entity.dart';

@immutable
class HomeState extends Equatable {
  final ViewData<List<MovieEntity>> homeState;

  const HomeState({
    required this.homeState,
  });

  HomeState copyWith({
    ViewData<List<MovieEntity>>? homeState,
  }) {
    return HomeState(
      homeState: homeState ?? this.homeState,
    );
  }

  @override
  List<Object?> get props => [homeState];
}
