import 'package:uni_translate_client/src/models/text_translation.dart';

class TranslateResponse {
  TranslateResponse({
    this.translations,
  });

  factory TranslateResponse.fromJson(Map<String, dynamic> json) {
    List<TextTranslation> translations = [];

    if (json['translations'] != null) {
      Iterable l = json['translations'] as List;
      translations = l.map((item) => TextTranslation.fromJson(item)).toList();
    }

    return TranslateResponse(
      translations: translations,
    );
  }

  List<TextTranslation>? translations;

  Map<String, dynamic> toJson() {
    return {
      'translations': (translations ?? []).map((e) => e.toJson()).toList(),
    }..removeWhere((key, value) => value == null);
  }
}
