import 'package:json_annotation/json_annotation.dart';

part 'word_phrase.g.dart';

// 常用短语/词组
@JsonSerializable()
class WordPhrase {
  WordPhrase({
    required this.text,
    required this.translations,
  });

  factory WordPhrase.fromJson(Map<String, dynamic> json) =>
      _$WordPhraseFromJson(json);

  final String text;
  final List<String> translations;

  Map<String, dynamic> toJson() => _$WordPhraseToJson(this);
}
