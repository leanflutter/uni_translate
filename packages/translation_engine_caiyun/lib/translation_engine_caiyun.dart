library translation_engine_caiyun;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uni_translate_client/uni_translate_client.dart';

const String kEngineTypeCaiyun = 'caiyun';

const String _kEngineOptionKeyToken = 'token';
const String _kEngineOptionKeyRequestId = 'requestId';

class CaiyunTranslationEngine extends TranslationEngine {
  CaiyunTranslationEngine({
    required super.identifier,
    super.option,
  });

  static List<String> optionKeys = [
    _kEngineOptionKeyToken,
    _kEngineOptionKeyRequestId,
  ];

  @override
  String get type => kEngineTypeCaiyun;

  @override
  List<TranslationEngineScope> get supportedScopes {
    return [
      TranslationEngineScope.translate,
    ];
  }

  String get _optionToken => option?[_kEngineOptionKeyToken] ?? '';
  String get _optionRequestId => option?[_kEngineOptionKeyRequestId] ?? '';

  @override
  Future<List<LanguagePair>> getSupportedLanguagePairs() {
    return Future.value([
      const LanguagePair(sourceLanguage: 'en', targetLanguage: 'zh'),
      const LanguagePair(sourceLanguage: 'ja', targetLanguage: 'zh'),
      const LanguagePair(sourceLanguage: 'zh', targetLanguage: 'en'),
      const LanguagePair(sourceLanguage: 'zh', targetLanguage: 'ja'),
    ]);
  }

  @override
  Future<DetectLanguageResponse> detectLanguage(DetectLanguageRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<LookUpResponse> lookUp(LookUpRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<TranslateResponse> translate(TranslateRequest request) async {
    List<TextTranslation> translations = [];

    String transType = 'auto';
    if (request.sourceLanguage != null && request.targetLanguage != null) {
      transType = '${request.sourceLanguage}2${request.targetLanguage}';
    }

    final payload = {
      'source': [request.text],
      'trans_type': transType,
      'request_id': _optionRequestId,
    };
    final response = await http.post(
      Uri.parse('http://api.interpreter.caiyunai.com/v1/translator'),
      headers: {
        'Content-Type': 'application/json',
        'X-Authorization': 'token $_optionToken',
      },
      body: json.encode(payload),
    );
    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    if (data['message'] != null) {
      throw UniTranslateClientError(message: data['message']);
    }

    translations = (data['target'] as List).map(
      (e) {
        return TextTranslation(text: e);
      },
    ).toList();

    return TranslateResponse(
      translations: translations,
    );
  }
}
