class LanguagePair {
  LanguagePair({
    this.sourceLanguage,
    this.sourceLanguageId,
    this.targetLanguage,
    this.targetLanguageId,
  });

  factory LanguagePair.fromJson(Map<String, dynamic> json) {
    return LanguagePair(
      sourceLanguage: json['sourceLanguage'],
      sourceLanguageId: json['sourceLanguageId'],
      targetLanguage: json['targetLanguage'],
      targetLanguageId: json['targetLanguageId'],
    );
  }

  final String? sourceLanguage;
  final String? sourceLanguageId;
  final String? targetLanguage;
  final String? targetLanguageId;

  Map<String, dynamic> toJson() {
    return {
      'sourceLanguage': sourceLanguage,
      'sourceLanguageId': sourceLanguageId,
      'targetLanguage': targetLanguage,
      'targetLanguageId': targetLanguageId,
    };
  }
}
