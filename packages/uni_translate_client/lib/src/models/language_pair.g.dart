// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas

part of 'language_pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguagePair _$LanguagePairFromJson(Map<String, dynamic> json) => LanguagePair(
      sourceLanguage: json['sourceLanguage'] as String?,
      sourceLanguageId: json['sourceLanguageId'] as String?,
      targetLanguage: json['targetLanguage'] as String?,
      targetLanguageId: json['targetLanguageId'] as String?,
    );

Map<String, dynamic> _$LanguagePairToJson(LanguagePair instance) =>
    <String, dynamic>{
      'sourceLanguage': instance.sourceLanguage,
      'sourceLanguageId': instance.sourceLanguageId,
      'targetLanguage': instance.targetLanguage,
      'targetLanguageId': instance.targetLanguageId,
    };
