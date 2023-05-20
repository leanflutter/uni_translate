class DetectLanguageRequest {
  DetectLanguageRequest({
    required this.texts,
  });

  factory DetectLanguageRequest.fromJson(Map<String, dynamic> json) {
    return DetectLanguageRequest(
      texts: json['texts'],
    );
  }

  final List<String> texts;

  Map<String, dynamic> toJson() {
    return {
      'texts': texts,
    };
  }
}
