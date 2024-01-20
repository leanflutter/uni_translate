import 'package:json_annotation/json_annotation.dart';

part 'text_detection.g.dart';

@JsonSerializable()
class TextDetection {
  const TextDetection({
    required this.detectedLanguage,
    required this.text,
  });

  factory TextDetection.fromJson(Map<String, dynamic> json) =>
      _$TextDetectionFromJson(json);

  final String detectedLanguage;
  final String text;

  Map<String, dynamic> toJson() => _$TextDetectionToJson(this);
}
