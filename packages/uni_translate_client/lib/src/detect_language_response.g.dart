// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detect_language_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetectLanguageResponse _$DetectLanguageResponseFromJson(
        Map<String, dynamic> json) =>
    DetectLanguageResponse(
      detections: (json['detections'] as List<dynamic>?)
          ?.map((e) => TextDetection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DetectLanguageResponseToJson(
        DetectLanguageResponse instance) =>
    <String, dynamic>{
      'detections': instance.detections,
    };
