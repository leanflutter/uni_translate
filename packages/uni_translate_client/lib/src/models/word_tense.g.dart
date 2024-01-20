// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_tense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordTense _$WordTenseFromJson(Map<String, dynamic> json) => WordTense(
      type: json['type'] as String?,
      name: json['name'] as String?,
      values:
          (json['values'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$WordTenseToJson(WordTense instance) => <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'values': instance.values,
    };
