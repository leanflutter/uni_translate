library translation_engine_deepl;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:uni_translate_client/uni_translate_client.dart';

const String kEngineTypeDeepL = 'deepl';

const String _kEngineOptionKeyAuthKey = 'authKey';

class DeepLTranslationEngine extends TranslationEngine {
  static List<String> optionKeys = [
    _kEngineOptionKeyAuthKey,
  ];

  DeepLTranslationEngine(TranslationEngineConfig config) : super(config);

  String get type => kEngineTypeDeepL;
  List<String> get supportedScopes => [kScopeTranslate];

  String get _optionAuthKey => option[_kEngineOptionKeyAuthKey];

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
    TranslateResponse translateResponse = TranslateResponse();

    Map<String, String> queryParameters = {
      'auth_key': _optionAuthKey,
      'text': request.text,
      'source_lang': request.sourceLanguage.toUpperCase(),
      'target_lang': request.targetLanguage.toUpperCase(),
    };
    var uri = Uri.https('api.deepl.com', '/v2/translate', queryParameters);

    var response = await http.post(uri, headers: {
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8"
    });

    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    if (data['translations'] != null) {
      Iterable l = data['translations'] as List;
      translateResponse.translations = l
          .map((e) => TextTranslation(
                detectedSourceLanguage: e['detected_source_language'],
                text: e['text'],
              ))
          .toList();
    }

    if (data['error'] != null) {
      throw UniTranslateClientError(message: data['errorMessage']);
    }

    return translateResponse;
  }
}
