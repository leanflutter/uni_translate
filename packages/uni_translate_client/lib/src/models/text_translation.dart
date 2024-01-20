import 'package:json_annotation/json_annotation.dart';

part 'text_translation.g.dart';

@JsonSerializable()
class TextTranslation {
  const TextTranslation({
    this.detectedSourceLanguage,
    required this.text,
    this.audioUrl,
  });

  factory TextTranslation.fromJson(Map<String, dynamic> json) =>
      _$TextTranslationFromJson(json);

  final String? detectedSourceLanguage;
  final String text;
  final String? audioUrl;

  Map<String, dynamic> toJson() => _$TextTranslationToJson(this);

  copyWith({
    String? detectedSourceLanguage,
    String? text,
    String? audioUrl,
  }) {
    return TextTranslation(
      detectedSourceLanguage:
          detectedSourceLanguage ?? this.detectedSourceLanguage,
      text: text ?? this.text,
      audioUrl: audioUrl ?? this.audioUrl,
    );
  }
}
