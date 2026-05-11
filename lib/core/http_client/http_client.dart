import 'package:dio/dio.dart';

class DioClient {
  final String baseUrl;
  final Interceptor? interceptor;

  DioClient(this.baseUrl, {this.interceptor});

  Dio get getDio {
    final Dio dio = Dio()
      ..options.baseUrl = baseUrl
      ..options.contentType = Headers.jsonContentType
      ..options.connectTimeout = const Duration(seconds: 15)
      ..options.sendTimeout = const Duration(seconds: 15)
      ..options.receiveTimeout = const Duration(seconds: 15);
    if (interceptor != null) {
      dio.interceptors.add(interceptor!);
    }
    return dio;
  }
}
