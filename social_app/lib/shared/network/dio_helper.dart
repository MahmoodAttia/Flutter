import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://fcm.googleapis.com/fcm/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future postNotification({
    required String deviceToken,
    required String title,
    required String body,
    required String imageUrl,
  }) async {
    dio.post(
      'send',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAQNer4r0:APA91bGI-KmqiVXWEV-52n1q7Fl-Os9SUnFQgjbM42hgjUI9DbGRh7ffFZqZRvh5gkwktXLYlhFLAfRiV8AsZbtFiNnEAj_pRar9JjMkd3ZRn8yVJ7ZkPLdd5DPSalvnCBPSDbjiKqMB',
        },
      ),
      data: {
        'to': '/topics/$deviceToken',
        'notification': {
          'title': title,
          'body': body,
          "mutable_content": true,
          "sound": "Tri-tone",
        },
        "data": {
          "url": imageUrl,
          "dl": "<deeplink action on tap of notification>"
        }
      },
    );
  }
}
