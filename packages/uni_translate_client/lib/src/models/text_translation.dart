class TextTranslation {
  TextTranslation({
    this.detectedSourceLanguage,
    required this.text,
    this.audioUrl,
  });

  factory TextTranslation.fromJson(Map<String, dynamic> json) {
    return TextTranslation(
      detectedSourceLanguage: json['detectedSourceLanguage'],
      text: json['text'],
      audioUrl: json['audioUrl'],
    );
  }

  String? detectedSourceLanguage;
  String text;
  String? audioUrl;

  Map<String, dynamic> toJson() {
    return {
      'detectedSourceLanguage': detectedSourceLanguage,
      'text': text,
      'audioUrl': audioUrl,
    };
  }
}
