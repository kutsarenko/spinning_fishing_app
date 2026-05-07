import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class AIResponseModel extends Equatable {
  final List<String> recommendedLures;
  final String activityLevel;
  final String fishindAdvice;

  const AIResponseModel({required this.recommendedLures, required this.activityLevel, required this.fishindAdvice});

  factory AIResponseModel.fromJson(Map<String, dynamic> json) => AIResponseModel(
    recommendedLures: (json['recommended_lures'] as List).map((lure) => lure.toString()).toList(),
    activityLevel: json['activity_level'] as String,
    fishindAdvice: json['fishing_advice'] as String,
  );

  factory AIResponseModel.fromGemini(Map<String, dynamic> json) {
    final candidates = json['candidates'] as List?;
    if (candidates == null || candidates.isEmpty) {
      throw Exception("Gemini: empty candidates");
    }

    final text = candidates.first['content']['parts'][0]['text'] as String;

    final cleanText = _cleanupJson(text);

    final map = jsonDecode(cleanText);

    return AIResponseModel(
      recommendedLures: (map['recommended_lures'] as List).map((lure) => lure.toString()).toList(),
      activityLevel: map['activity_level'] as String,
      fishindAdvice: map['fishing_advice'] as String,
    );
  }

  static String _cleanupJson(String raw) {
    return raw.replaceAll('```json', '').replaceAll('```', '').trim();
  }

  @override
  List<Object?> get props => [recommendedLures, activityLevel, fishindAdvice];
}
