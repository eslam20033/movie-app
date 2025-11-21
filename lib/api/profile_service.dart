import 'package:dio/dio.dart';
import 'package:flutter_application_1/api/api_endpoints.dart';
import 'package:flutter_application_1/api/auth_service.dart';

import 'dio_helper.dart';

class ProfileService {
  static Future<Response> getUser() async {
    return await DioHelper.getData(url: ApiEndPoints.profile);
  }

  static Future<Response> updateUser({
    String? name,
    String? phone,
    int? avatarId,
  }) {
    return DioHelper.updateData(
      url: ApiEndPoints.profile,
      data: {
        if (name != null) "name": name,
        if (phone != null) "phone": phone,
        if (avatarId != null) "avaterId": avatarId,
      },
    );
  }

  static Future<Response> deleteUser() {
    return DioHelper.deleteData(url: ApiEndPoints.profile);
  }

  static Future<Response> addFavorite({
    required String movieId,
    required String name,
    required double rating,
    required String imageURL,
    required String year,
  }) async {
    return await DioHelper.dio!.post(
      ApiEndPoints.addFavourite,
      data: {
        "movieId": movieId,
        "name": name,
        "rating": rating,
        "imageURL": imageURL,
        "year": year,
      },
    );
  }

  static Future<void> removeFavorite({required int movieId}) async {
    await DioHelper.deleteData(url: '${ApiEndPoints.deleteMovie}/$movieId');
  }

  static Future<Response> getFavorite({required int movieId}) async {
    return await DioHelper.getData(
      url: '${ApiEndPoints.movieIsFavourite}/$movieId',
    );
  }

  static Future<Response> getAllFavorite() async {
    return await DioHelper.getData(url: ApiEndPoints.getAllFavourites);
  }
}
