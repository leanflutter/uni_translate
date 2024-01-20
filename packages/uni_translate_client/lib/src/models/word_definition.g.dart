// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordDefinition _$WordDefinitionFromJson(Map<String, dynamic> json) =>
    WordDefinition(
      type: json['type'] as String?,
      name: json['name'] as String?,
      values:
          (json['values'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$WordDefinitionToJson(WordDefinition instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'values': instance.values,
    };
