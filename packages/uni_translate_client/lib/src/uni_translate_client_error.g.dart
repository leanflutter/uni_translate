// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas

part of 'uni_translate_client_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniTranslateClientError _$UniTranslateClientErrorFromJson(
        Map<String, dynamic> json) =>
    UniTranslateClientError(
      code: json['code'] as String?,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UniTranslateClientErrorToJson(
        UniTranslateClientError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
