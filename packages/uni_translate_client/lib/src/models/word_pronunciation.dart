import 'package:json_annotation/json_annotation.dart';

part 'word_pronunciation.g.dart';

@JsonSerializable()
class WordPronunciation {
  const WordPronunciation({
    this.type,
    this.phoneticSymbol,
    this.audioUrl,
  });

  factory WordPronunciation.fromJson(Map<String, dynamic> json) =>
      _$WordPronunciationFromJson(json);

  final String? type;
  final String? phoneticSymbol;
  final String? audioUrl;

  Map<String, dynamic> toJson() => _$WordPronunciationToJson(this);
}
