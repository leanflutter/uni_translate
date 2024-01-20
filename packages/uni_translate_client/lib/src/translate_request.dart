import 'package:json_annotation/json_annotation.dart';

part 'translate_request.g.dart';

@JsonSerializable()
class TranslateRequest {
  const TranslateRequest({
    this.sourceLanguage,
    this.targetLanguage,
    required this.text,
  });

  factory TranslateRequest.fromJson(Map<String, dynamic> json) =>
      _$TranslateRequestFromJson(json);

  final String? sourceLanguage;
  final String? targetLanguage;
  final String text;

  Map<String, dynamic> toJson() => _$TranslateRequestToJson(this);
}
