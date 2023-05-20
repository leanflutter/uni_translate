class WordPronunciation {
  WordPronunciation({
    this.type,
    this.phoneticSymbol,
    this.audioUrl,
  });

  factory WordPronunciation.fromJson(Map<String, dynamic> json) {
    return WordPronunciation(
      type: json['type'],
      phoneticSymbol: json['phoneticSymbol'],
      audioUrl: json['audioUrl'],
    );
  }

  String? type;
  String? phoneticSymbol;
  String? audioUrl;

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'phoneticSymbol': phoneticSymbol,
      'audioUrl': audioUrl,
    }..removeWhere((key, value) => value == null);
  }
}
