import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static dioinit() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true),
    );
  }
  //comment

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? queries,
    Map<String, dynamic>? headers,
  }) async {
    dio!.options.headers = headers;

    return await dio!.get(
      path,
      queryParameters: queries,
    );
  }

  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? queries,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    dio!.options.headers = headers;

    return await dio!.put(
      path,
      queryParameters: queries,
      data: data,
    );
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? queries,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    dio!.options.headers = headers;
    return await dio!.post(path, queryParameters: queries, data: data);
  }
}
