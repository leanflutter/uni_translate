class TextDetection {
  TextDetection({
    required this.detectedLanguage,
    required this.text,
  });

  factory TextDetection.fromJson(Map<String, dynamic> json) {
    return TextDetection(
      detectedLanguage: json['detectedLanguage'],
      text: json['text'],
    );
  }

  String detectedLanguage;
  String text;

  Map<String, dynamic> toJson() {
    return {
      'detectedLanguage': detectedLanguage,
      'text': text,
    };
  }
}
