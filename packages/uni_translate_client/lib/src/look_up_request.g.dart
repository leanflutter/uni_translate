// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas

part of 'look_up_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookUpRequest _$LookUpRequestFromJson(Map<String, dynamic> json) =>
    LookUpRequest(
      sourceLanguage: json['sourceLanguage'] as String?,
      targetLanguage: json['targetLanguage'] as String?,
      word: json['word'] as String,
    );

Map<String, dynamic> _$LookUpRequestToJson(LookUpRequest instance) =>
    <String, dynamic>{
      'sourceLanguage': instance.sourceLanguage,
      'targetLanguage': instance.targetLanguage,
      'word': instance.word,
    };
