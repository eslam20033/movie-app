import 'package:dio/dio.dart';

import '../core/storage.dart';
import 'api_const.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'},
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenManager.get();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          TokenManager.delete();
          // Navigator to login...
        }
        return handler.next(e);
      },
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return await dio!.post(url, data: data);
  }

  static Future<Response> updateData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    return await dio!.patch(url, data: data);
  }

  static Future<Response> deleteData({required String url}) async {
    return await dio!.delete(url);
  }

  static Future<Response> postLogin({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return await dio!.post(url, data: data);
  }

  static Future<Response> postRegister({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    return await dio!.post(url, data: data);
  }

  // static Future<Response> getIsFavorite({
  //   required String url,
  //   required String token,
  // }) async {
  //   return await dio!.get(
  //     url,
  //   );
  // }
  // static Future<Response> getAllFavorite({
  //   required String url,
  //   required String token,
  // }) async {
  //   return await dio!.get(
  //     url,
  //   );
  // }
}
