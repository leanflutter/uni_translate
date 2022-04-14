class WordSentence {
  final String text;
  final List<String> translations;

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

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'translations': translations,
    }..removeWhere((key, value) => value == null);
  }
}
