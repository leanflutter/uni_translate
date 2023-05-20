class WordSentence {
  WordSentence({
    required this.text,
    required this.translations,
  });

  factory WordSentence.fromJson(Map<String, dynamic> json) {
    return WordSentence(
      text: json['text'],
      translations: List<String>.from(json['translations']),
    );
  }

  final String text;
  final List<String> translations;

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'translations': translations,
    }..removeWhere((key, value) => value == null);
  }
}
