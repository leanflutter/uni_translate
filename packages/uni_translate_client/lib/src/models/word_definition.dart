import 'package:json_annotation/json_annotation.dart';

part 'word_definition.g.dart';

@JsonSerializable()
class WordDefinition {
  const WordDefinition({
    this.type,
    this.name,
    this.values,
  });

  factory WordDefinition.fromJson(Map<String, dynamic> json) =>
      _$WordDefinitionFromJson(json);

  final String? type;
  final String? name;
  final List<String>? values;

  Map<String, dynamic> toJson() => _$WordDefinitionToJson(this);
}
