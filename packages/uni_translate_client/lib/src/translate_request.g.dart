// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translate_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslateRequest _$TranslateRequestFromJson(Map<String, dynamic> json) =>
    TranslateRequest(
      sourceLanguage: json['sourceLanguage'] as String?,
      targetLanguage: json['targetLanguage'] as String?,
      text: json['text'] as String,
    );

Map<String, dynamic> _$TranslateRequestToJson(TranslateRequest instance) =>
    <String, dynamic>{
      'sourceLanguage': instance.sourceLanguage,
      'targetLanguage': instance.targetLanguage,
      'text': instance.text,
    };
