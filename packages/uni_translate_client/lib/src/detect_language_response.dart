import 'models/text_detection.dart';

class DetectLanguageResponse {
  List<TextDetection> detections;

  DetectLanguageResponse({
    this.detections,
  });

  factory DetectLanguageResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return DetectLanguageResponse(
      detections: json['detections'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'detections': detections?.map((e) => e.toJson())?.toList(),
    }..removeWhere((key, value) => value == null);
  }
}
