// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas

part of 'word_sentence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordSentence _$WordSentenceFromJson(Map<String, dynamic> json) => WordSentence(
      text: json['text'] as String,
      translations: (json['translations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$WordSentenceToJson(WordSentence instance) =>
    <String, dynamic>{
      'text': instance.text,
      'translations': instance.translations,
    };
