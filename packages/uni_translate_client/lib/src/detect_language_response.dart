import 'package:uni_translate_client/src/models/text_detection.dart';

class DetectLanguageResponse {
  DetectLanguageResponse({
    this.detections,
  });

  factory DetectLanguageResponse.fromJson(Map<String, dynamic> json) {
    List<TextDetection> detections = [];

    if (json['detections'] != null) {
      Iterable l = json['detections'] as List;
      detections = l.map((item) => TextDetection.fromJson(item)).toList();
    }

    return DetectLanguageResponse(
      detections: detections,
    );
  }

  List<TextDetection>? detections;

  Map<String, dynamic> toJson() {
    return {
      'detections': (detections ?? []).map((e) => e.toJson()).toList(),
    }..removeWhere((key, value) => value == null);
  }
}
