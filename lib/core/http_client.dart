import 'package:dio/dio.dart';

class DioClient {
  final String baseUrl;

  DioClient(this.baseUrl);

  Dio get getDio {
    final Dio dio = Dio()
      ..options.baseUrl = baseUrl
      ..options.contentType = Headers.jsonContentType
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.sendTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 10);
    return dio;
  }
}
