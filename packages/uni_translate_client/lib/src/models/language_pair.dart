class LanguagePair {
  final String sourceLanguage;
  final String sourceLanguageId;
  final String targetLanguage;
  final String targetLanguageId;

  LanguagePair({
    this.sourceLanguage,
    this.sourceLanguageId,
    this.targetLanguage,
    this.targetLanguageId,
  });

  factory LanguagePair.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return LanguagePair(
      sourceLanguage: json['sourceLanguage'],
      sourceLanguageId: json['sourceLanguageId'],
      targetLanguage: json['targetLanguage'],
      targetLanguageId: json['targetLanguageId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sourceLanguage': sourceLanguage,
      'sourceLanguageId': sourceLanguageId,
      'targetLanguage': targetLanguage,
      'targetLanguageId': targetLanguageId,
    };
  }
}
