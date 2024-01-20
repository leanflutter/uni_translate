// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_phrase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordPhrase _$WordPhraseFromJson(Map<String, dynamic> json) => WordPhrase(
      text: json['text'] as String,
      translations: (json['translations'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$WordPhraseToJson(WordPhrase instance) =>
    <String, dynamic>{
      'text': instance.text,
      'translations': instance.translations,
    };
