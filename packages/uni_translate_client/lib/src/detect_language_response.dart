import 'package:json_annotation/json_annotation.dart';
import 'package:uni_translate_client/src/models/text_detection.dart';

part 'detect_language_response.g.dart';

@JsonSerializable()
class DetectLanguageResponse {
  const DetectLanguageResponse({
    this.detections,
  });

  factory DetectLanguageResponse.fromJson(Map<String, dynamic> json) =>
      _$DetectLanguageResponseFromJson(json);

  final List<TextDetection>? detections;

  Map<String, dynamic> toJson() => _$DetectLanguageResponseToJson(this);
}
