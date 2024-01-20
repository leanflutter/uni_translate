import 'package:json_annotation/json_annotation.dart';

part 'word_sentence.g.dart';

@JsonSerializable()
class WordSentence {
  const WordSentence({
    required this.text,
    required this.translations,
  });

  factory WordSentence.fromJson(Map<String, dynamic> json) =>
      _$WordSentenceFromJson(json);

  final String text;
  final List<String> translations;

  Map<String, dynamic> toJson() => _$WordSentenceToJson(this);
}
