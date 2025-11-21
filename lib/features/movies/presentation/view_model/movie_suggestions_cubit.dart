import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/movie_model.dart';
import '../../data/repositories/movie_suggestions_repo.dart';

part 'movie_suggestions_state.dart';

class MovieSuggestionsCubit extends Cubit<MovieSuggestionsState> {
  MovieSuggestionsCubit() : super(MovieSuggestionsInitial());

  getSuggestionsMovies({required int movieId}) async {
    emit(MovieSuggestionsLoading());
    try {
      final suggestionsMovieList = await MovieSuggestionsRepo()
          .getSuggestionsMovies(movieId: movieId);
      emit(MovieSuggestionsSuccess(suggestionsMovies: suggestionsMovieList));
    } catch (e) {
      emit(
        MovieSuggestionsError(message: 'Error fetching suggested movies: $e'),
      );
    }
  }
}
