// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_detection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextDetection _$TextDetectionFromJson(Map<String, dynamic> json) =>
    TextDetection(
      detectedLanguage: json['detectedLanguage'] as String,
      text: json['text'] as String,
    );

Map<String, dynamic> _$TextDetectionToJson(TextDetection instance) =>
    <String, dynamic>{
      'detectedLanguage': instance.detectedLanguage,
      'text': instance.text,
    };
