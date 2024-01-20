// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'look_up_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookUpResponse _$LookUpResponseFromJson(Map<String, dynamic> json) =>
    LookUpResponse(
      translations: (json['translations'] as List<dynamic>?)
              ?.map((e) => TextTranslation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      word: json['word'] as String?,
      tip: json['tip'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => WordTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      definitions: (json['definitions'] as List<dynamic>?)
          ?.map((e) => WordDefinition.fromJson(e as Map<String, dynamic>))
          .toList(),
      pronunciations: (json['pronunciations'] as List<dynamic>?)
          ?.map((e) => WordPronunciation.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => WordImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      phrases: (json['phrases'] as List<dynamic>?)
          ?.map((e) => WordPhrase.fromJson(e as Map<String, dynamic>))
          .toList(),
      tenses: (json['tenses'] as List<dynamic>?)
          ?.map((e) => WordTense.fromJson(e as Map<String, dynamic>))
          .toList(),
      sentences: (json['sentences'] as List<dynamic>?)
          ?.map((e) => WordSentence.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LookUpResponseToJson(LookUpResponse instance) =>
    <String, dynamic>{
      'translations': instance.translations,
      'word': instance.word,
      'tip': instance.tip,
      'tags': instance.tags,
      'definitions': instance.definitions,
      'pronunciations': instance.pronunciations,
      'images': instance.images,
      'phrases': instance.phrases,
      'tenses': instance.tenses,
      'sentences': instance.sentences,
    };
