// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_pronunciation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordPronunciation _$WordPronunciationFromJson(Map<String, dynamic> json) =>
    WordPronunciation(
      type: json['type'] as String?,
      phoneticSymbol: json['phoneticSymbol'] as String?,
      audioUrl: json['audioUrl'] as String?,
    );

Map<String, dynamic> _$WordPronunciationToJson(WordPronunciation instance) =>
    <String, dynamic>{
      'type': instance.type,
      'phoneticSymbol': instance.phoneticSymbol,
      'audioUrl': instance.audioUrl,
    };
