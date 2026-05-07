import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AITokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String token = dotenv.get('OPENAI_API_KEY');
    if (token.isEmpty) {
      return handler.reject(
        DioException(requestOptions: options, type: DioExceptionType.cancel, error: 'Отсутствует OpenAI-токен'),
      );
    }
    options.headers['x-goog-api-key'] = token;

    return handler.next(options);
  }
}
