class WordSentence {
  final String text;
  final List<String> translations;

  WordSentence({
    this.text,
    this.translations,
  });

  factory WordSentence.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return WordSentence(
      text: json['text'],
      translations: json['translations'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'translations': translations,
    }..removeWhere((key, value) => value == null);
  }
}
