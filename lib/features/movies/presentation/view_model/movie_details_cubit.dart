import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/features/movies/data/repositories/movie_detalis_repository.dart';
import 'package:meta/meta.dart';

import '../../data/models/movie_details_model.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitial());

  Future<void> fetchMovieDetails(int movieId) async {
    try {
      final result = await MovieDetailsRepository.getMovieDetails(
        movieId: movieId,
      );
      if (result != null) {
        List<String> screenShoots = [
          ?result.largeScreenshotImage1,
          ?result.largeScreenshotImage2,
          ?result.largeScreenshotImage3,
        ];
        emit(
          MovieDetailsSuccessState(
            movieDetails: result,
            screenShoots: screenShoots,
          ),
        );
      } else {
        emit(MovieDetailsEmptyState('No details found for this movie.'));
      }
    } catch (e) {
      emit(MovieDetailsErrorState(e.toString()));
    }
  }
}
