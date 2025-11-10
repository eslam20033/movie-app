part of 'movie_cubit.dart';

@immutable
sealed class MovieState {}

final class MovieInitial extends MovieState {}

final class MovieLoadingState extends MovieState {}

final class MovieSuccessState extends MovieState {
  final List<Movies> featured;
  final List<Movies> action;

  MovieSuccessState({required this.featured, required this.action});
}
final class SearchSuccessState extends MovieState {
  final List<Movies> movieList;

  SearchSuccessState({required this.movieList});
}
final class MovieErrorState extends MovieState {
  final String error;

  MovieErrorState(this.error);
}

final class MovieEmptyState extends MovieState {
  final String message;

  MovieEmptyState(this.message);
}
