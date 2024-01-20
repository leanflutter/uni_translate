import 'package:json_annotation/json_annotation.dart';

part 'detect_language_request.g.dart';

@JsonSerializable()
class DetectLanguageRequest {
  const DetectLanguageRequest({
    required this.texts,
  });

  factory DetectLanguageRequest.fromJson(Map<String, dynamic> json) =>
      _$DetectLanguageRequestFromJson(json);

  final List<String> texts;

  Map<String, dynamic> toJson() => _$DetectLanguageRequestToJson(this);
}
