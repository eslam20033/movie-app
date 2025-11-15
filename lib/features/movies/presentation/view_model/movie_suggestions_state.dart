part of 'movie_suggestions_cubit.dart';

@immutable
sealed class MovieSuggestionsState {}

final class MovieSuggestionsInitial extends MovieSuggestionsState {}

final class MovieSuggestionsLoading extends MovieSuggestionsState {}

final class MovieSuggestionsSuccess extends MovieSuggestionsState {
  final List<Movies> suggestionsMovies;

  MovieSuggestionsSuccess({required this.suggestionsMovies});
}

final class MovieSuggestionsError extends MovieSuggestionsState {
  final String message;

  MovieSuggestionsError({
    this.message = 'An error occurred while fetching suggested movies.',
  });
}
