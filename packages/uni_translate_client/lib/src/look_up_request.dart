import 'package:uni_translate_client/src/translate_request.dart';

class LookUpRequest extends TranslateRequest {
  LookUpRequest({
    required String sourceLanguage,
    required String targetLanguage,
    required this.word,
  }) : super(
          sourceLanguage: sourceLanguage,
          targetLanguage: targetLanguage,
          text: word,
        );

  factory LookUpRequest.fromJson(Map<String, dynamic> json) {
    return LookUpRequest(
      sourceLanguage: json['sourceLanguage'],
      targetLanguage: json['targetLanguage'],
      word: json['word'],
    );
  }

  final String word;

  @override
  Map<String, dynamic> toJson() {
    return {
      'sourceLanguage': sourceLanguage,
      'targetLanguage': targetLanguage,
      'word': word,
    };
  }
}
