import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future getData({
    @required String url,
    @required Map<String, dynamic> queries,
  }) async {
    return await dio.get(
      url,
      queryParameters: queries,
    );
  }
}

// https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=ac03323163974c35a68e17de5d6fc585