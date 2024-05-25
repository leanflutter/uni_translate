// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas

part of 'detect_language_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetectLanguageRequest _$DetectLanguageRequestFromJson(
        Map<String, dynamic> json) =>
    DetectLanguageRequest(
      texts: (json['texts'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DetectLanguageRequestToJson(
        DetectLanguageRequest instance) =>
    <String, dynamic>{
      'texts': instance.texts,
    };
