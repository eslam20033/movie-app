import 'package:dio/dio.dart';
import 'package:flutter_application_1/api/api_const.dart';

class DioMovieHelper {
  static Dio? dio;

  static init() {
    dio =
        Dio(
            BaseOptions(
              baseUrl: ApiConst.movieBaseUrl,
              receiveDataWhenStatusError: true,
              headers: {'Content-Type': 'application/json'},
              connectTimeout: const Duration(seconds: 20),
              receiveTimeout: const Duration(seconds: 20),
            ),
          )
          ..interceptors.add(
            LogInterceptor(request: true, error: true, responseBody: true),
          );
  }

  static Future<Response> getMovieData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.get(url, queryParameters: query);
  }
}
