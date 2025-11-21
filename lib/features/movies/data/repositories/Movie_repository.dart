import 'dart:developer';

import '../api/dio_movie_helper.dart';
import '../api/movie_endpoints.dart';
import '../models/movie_model.dart';

class MovieRepository {
  Future<List<Movies>> getMovies({int page = 1, int limit = 30}) async {
    try {
      final response = await DioMovieHelper.getMovieData(
        url: MovieEndpoints.movieEndpoint,
        query: {'page_number': page, 'limit': limit},
      );

      if (response.statusCode == 200 && response.data != null) {
        final movieModel = MovieModel.fromJson(response.data);
        return movieModel.data?.movies ?? [];
      } else {
        log('Failed to load movies: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching movies: $e');
      return [];
    }
  }

  Future<List<Movies>> searchOnMovies({String? search,int? limit}) async {
    try {
      final response = await DioMovieHelper.getMovieData(
        url: MovieEndpoints.movieEndpoint,
        query: {'query_term': search, 'limit': limit},
      );
      if (response.statusCode == 200 && response.data != null) {
        final result = MovieModel.fromJson(response.data);
        return result.data?.movies ?? [];
      } else {
        log('Failed to load movies: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching movies: $e');
      return [];
    }
  }
}
