import 'package:flutter_application_1/features/movies/data/api/movie_endpoints.dart';
import 'package:flutter_application_1/features/movies/data/models/movie_model.dart';

import '../api/dio_movie_helper.dart';

class MovieSuggestionsRepo {
  Future<List<Movies>> getSuggestionsMovies({required int movieId}) async {
    try {
      final response = await DioMovieHelper.getMovieData(
        url: MovieEndpoints.movieSuggestionEndpoint,
        query: {'movie_id': movieId},
      );
      if (response.statusCode == 200 && response.data != null) {
        final suggestionsMovies = MovieModel.fromJson(response.data);
        return suggestionsMovies.data?.movies ?? [];
      } else {
        print('Error: ${response.statusCode}');
        return throw Exception('Failed to load suggested movies');
      }
    } catch (e) {
      return throw Exception('Error fetching suggested movies: $e');
    }
  }
}
