part of 'movie_details_cubit.dart';

@immutable
sealed class MovieDetailsState {}

final class MovieDetailsInitial extends MovieDetailsState {}

final class MovieDetailsLoadingState extends MovieDetailsState {}

final class MovieDetailsEmptyState extends MovieDetailsState {
  final String message;

  MovieDetailsEmptyState(this.message);
}

final class MovieDetailsErrorState extends MovieDetailsState {
  final String error;

  MovieDetailsErrorState(this.error);
}

final class MovieDetailsSuccessState extends MovieDetailsState {
  final Movie movieDetails;
  final List<String>? screenShoots;

  MovieDetailsSuccessState({required this.movieDetails, this.screenShoots});
}
