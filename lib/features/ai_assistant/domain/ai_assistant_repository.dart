import 'package:spinning_fishing_app/features/ai_assistant/data/ai_assistant_service.dart';
import 'package:spinning_fishing_app/features/ai_assistant/data/models/ai_request_dto.dart';
import 'package:spinning_fishing_app/features/ai_assistant/data/models/ai_response_model.dart';

abstract interface class AIAssistantRepository {
  Future<AIResponseModel> getFishingAdvice(AIRequestDTO dto);
}

class AIAssistantRepositoryImpl implements AIAssistantRepository {
  final AIAssistantService _aiAssistantService;

  const AIAssistantRepositoryImpl(AIAssistantService aiAssistantService) : _aiAssistantService = aiAssistantService;

  @override
  Future<AIResponseModel> getFishingAdvice(AIRequestDTO dto) async {
    try {
      return await _aiAssistantService.getFishingAdvice(dto);
    } catch (_) {
      rethrow;
    }
  }
}
