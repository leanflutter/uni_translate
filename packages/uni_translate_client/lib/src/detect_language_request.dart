class DetectLanguageRequest {
  final List<String> texts;

  DetectLanguageRequest({
    required this.texts,
  });

  factory DetectLanguageRequest.fromJson(Map<String, dynamic> json) {
    return DetectLanguageRequest(
      texts: json['texts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'texts': texts,
    };
  }
}
