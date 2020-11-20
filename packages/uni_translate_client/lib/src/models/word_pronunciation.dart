class WordPronunciation {
  String type;
  String phoneticSymbol;
  String audioUrl;

  WordPronunciation({this.type, this.phoneticSymbol, this.audioUrl});

  factory WordPronunciation.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return WordPronunciation(
      type: json['type'],
      phoneticSymbol: json['phoneticSymbol'],
      audioUrl: json['audioUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'phoneticSymbol': phoneticSymbol,
      'audioUrl': audioUrl,
    }..removeWhere((key, value) => value == null);
  }
}
