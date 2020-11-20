class TextTranslation {
  String detectedSourceLanguage;
  String text;
  String audioUrl;

  TextTranslation({
    this.detectedSourceLanguage,
    this.text,
    this.audioUrl,
  });

  factory TextTranslation.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return TextTranslation(
      detectedSourceLanguage: json['detectedSourceLanguage'],
      text: json['text'],
      audioUrl: json['audioUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'detectedSourceLanguage': detectedSourceLanguage,
      'text': text,
      'audioUrl': audioUrl,
    };
  }
}
