import 'package:json_annotation/json_annotation.dart';

part 'word_tense.g.dart';

@JsonSerializable()
class WordTense {
  const WordTense({
    this.type,
    this.name,
    this.values,
  });
  factory WordTense.fromJson(Map<String, dynamic> json) =>
      _$WordTenseFromJson(json);

  final String? type;
  final String? name;
  final List<String>? values;

  Map<String, dynamic> toJson() => _$WordTenseToJson(this);
}
