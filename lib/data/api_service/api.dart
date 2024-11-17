import 'package:dio/dio.dart';
import 'package:e_voting/core/constant.dart';

class Api {
  Dio? _dio;

  Dio get dio {
    if (_dio != null) {
      return _dio!;
    } else {
      var dio = Dio(
        BaseOptions(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          baseUrl: baseUrl,
          receiveTimeout: const Duration(seconds: 45),
          connectTimeout: const Duration(seconds: 250),
          sendTimeout: const Duration(seconds: 45),
          validateStatus: (statusCode) {
            return true;
            // if (statusCode == null) {
            //   return false;
            // }
            // if (statusCode == 422) {
            //   // your http status code
            //   return true;
            // } else {
            //   return statusCode >= 200 && statusCode < 300;
            // }
          },
        ),
      );
      return dio;
    }
  }

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;
}
