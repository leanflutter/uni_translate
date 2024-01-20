import 'package:json_annotation/json_annotation.dart';

part 'word_tag.g.dart';

@JsonSerializable()
class WordTag {
  const WordTag({
    required this.name,
  });

  factory WordTag.fromJson(Map<String, dynamic> json) =>
      _$WordTagFromJson(json);

  final String name;

  Map<String, dynamic> toJson() => _$WordTagToJson(this);
}
