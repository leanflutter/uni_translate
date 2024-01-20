import 'package:json_annotation/json_annotation.dart';

part 'language_pair.g.dart';

@JsonSerializable()
class LanguagePair {
  const LanguagePair({
    this.sourceLanguage,
    this.sourceLanguageId,
    this.targetLanguage,
    this.targetLanguageId,
  });

  factory LanguagePair.fromJson(Map<String, dynamic> json) =>
      _$LanguagePairFromJson(json);

  final String? sourceLanguage;
  final String? sourceLanguageId;
  final String? targetLanguage;
  final String? targetLanguageId;

  Map<String, dynamic> toJson() => _$LanguagePairToJson(this);
}
