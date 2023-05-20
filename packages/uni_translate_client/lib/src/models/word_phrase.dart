// 常用短语/词组
class WordPhrase {
  WordPhrase({
    required this.text,
    required this.translations,
  });

  factory WordPhrase.fromJson(Map<String, dynamic> json) {
    return WordPhrase(
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
