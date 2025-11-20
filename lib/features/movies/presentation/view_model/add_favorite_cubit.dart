import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/api/api_const.dart';
import 'package:flutter_application_1/api/profile_service.dart';
import 'package:meta/meta.dart';

import '../../../../model/get_all_favorite_model.dart';

part 'add_favorite_state.dart';

class AddFavoriteCubit extends Cubit<AddFavoriteState> {
  AddFavoriteCubit() : super(AddFavoriteInitial());

  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;

  Future<void> toggleFavorite({
    required int movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  }) async {
    // final token = await SecureStorage.getToken();
    // if (token == null) return;
    emit(AddFavoriteLoading());
    try {
      if (_isFavorite) {
        final response = await ProfileService.removeFavorite(
          movieId: movieId,
        );
        _isFavorite = false;
        emit(AddFavoriteRemoved());
      } else {
        await ProfileService.addFavorite(
          movieId: movieId.toString(),
          name: name,
          rating: rating,
          imageURL: imageURL,
          year: year,
        );
        _isFavorite = true;
        await checkIfFavorite(movieId);
        emit(AddFavoriteSuccess(isFavorite: _isFavorite));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        _isFavorite = true;
        emit(AddFavoriteSuccess(isFavorite: _isFavorite));
      } else {
        emit(AddFavoriteError(errorMessage: 'Error'));
      }
    } catch (e) {
      emit(AddFavoriteError(errorMessage: e.toString()));
    }
  }

  Future<bool> getIsFavorite({required int movieId}) async {
    try {
      emit(GetFavoriteLoading());

      final response = await ProfileService.getFavorite(
        movieId: movieId,
      );
      final data = response.data;
      bool isFav = false;
      if (data is Map<String, dynamic>) {
        final val = data["data"];
        if (val is bool) isFav = val;
        if (val is int) isFav = val != 0;
        if (val is String) isFav = val.toLowerCase() == 'true' || val == '1';
      }

      _isFavorite = isFav;

      emit(GetFavoriteSuccess(isFavorite: _isFavorite));

      return isFav;
    } catch (e) {
      emit(GetFavoriteError(errorMessage: e.toString()));
      return false;
    }
  }

  List<Data>? favoriteList;

  Future<void> getAllFavoriteData() async {
    try {
      emit(GetAllFavoriteLoading());

      final response = await ProfileService.getAllFavorite();

      if (response.statusCode == 200) {
        final result = GetAllFavoriteModel.fromJson(response.data);
        favoriteList = result.data ?? [];

        emit(GetAllFavoriteSuccess(favoriteList: favoriteList!));
      } else {
        emit(GetAllFavoriteError(errorMessage: "Failed with status: ${response.statusCode}"));
      }
    } catch (e) {
      emit(
        GetAllFavoriteError(
          errorMessage: 'Something Went Wrong: ${e.toString()}',
        ),
      );
    }
  }


  Future<void> checkIfFavorite(int movieId) async {
    final isFav = await getIsFavorite(movieId: movieId);
    _isFavorite = isFav;
    log('Favorite status for movie $movieId: $_isFavorite'); // Debugging
    emit(AddFavoriteChecked(isFavorite: _isFavorite));
  }
}
