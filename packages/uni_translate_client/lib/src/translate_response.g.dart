// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas

part of 'translate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslateResponse _$TranslateResponseFromJson(Map<String, dynamic> json) =>
    TranslateResponse(
      translations: (json['translations'] as List<dynamic>?)
              ?.map((e) => TextTranslation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TranslateResponseToJson(TranslateResponse instance) =>
    <String, dynamic>{
      'translations': instance.translations,
    };
