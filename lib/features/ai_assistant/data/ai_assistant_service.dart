import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:spinning_fishing_app/core/http_client/http_client.dart';
import 'package:spinning_fishing_app/features/ai_assistant/data/models/ai_request_dto.dart';
import 'package:spinning_fishing_app/features/ai_assistant/data/models/ai_response_model.dart';

abstract interface class AIAssistantService {
  Future<AIResponseModel> getFishingAdvice(AIRequestDTO dto);
}

class AIAssistantServiceImpl implements AIAssistantService {
  final DioClient _dioClient;

  const AIAssistantServiceImpl(DioClient dioClient) : _dioClient = dioClient;

  @override
  Future<AIResponseModel> getFishingAdvice(AIRequestDTO dto) async {
    const String path = 'v1beta/models/gemini-2.5-flash:generateContent';
    try {
      final response = await _dioClient.getDio.post(
        path,
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: dto.toJson(),
      );

      return AIResponseModel.fromGemini(response.data as Map<String, dynamic>);
    } catch (e, stackTrace) {
      debugPrint('Getting fishing advice error: $e\n$stackTrace');
      rethrow;
    }
  }
}
