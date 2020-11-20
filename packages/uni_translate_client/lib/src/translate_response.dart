import 'models/text_translation.dart';

class TranslateResponse {
  List<TextTranslation> translations;

  TranslateResponse({
    this.translations,
  });

  factory TranslateResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    List<TextTranslation> translations;

    return TranslateResponse(
      translations: translations,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'translations': translations?.map((e) => e.toJson())?.toList(),
    }..removeWhere((key, value) => value == null);
  }
}
