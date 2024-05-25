// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas

part of 'text_translation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextTranslation _$TextTranslationFromJson(Map<String, dynamic> json) =>
    TextTranslation(
      detectedSourceLanguage: json['detectedSourceLanguage'] as String?,
      text: json['text'] as String,
      audioUrl: json['audioUrl'] as String?,
    );

Map<String, dynamic> _$TextTranslationToJson(TextTranslation instance) =>
    <String, dynamic>{
      'detectedSourceLanguage': instance.detectedSourceLanguage,
      'text': instance.text,
      'audioUrl': instance.audioUrl,
    };
