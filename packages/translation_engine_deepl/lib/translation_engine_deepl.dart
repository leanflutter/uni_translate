library translation_engine_deepl;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:uni_translate_client/uni_translate_client.dart';

const String kEngineTypeDeepL = 'deepl';

const String _kEngineOptionKeyAuthKey = 'authKey';

const Map<String, String> _knownErrors = {
  '400': 'Bad request. Please check error message and your parameters.',
  '401':
      'Authorization failed. Please supply a valid DeepL-Auth-Key via the Authorization header.',
  '403':
      'Forbidden. The access to the requested resource is denied, because of insufficient access rights.',
  '404': 'The requested resource could not be found.',
  '413': 'The request size exceeds the limit.',
  '415':
      'The requested entries format specified in the Accept header is not supported.',
  '429': 'Too many requests. Please wait and resend your request.',
  '456': 'Quota exceeded. The maximum amount of glossaries has been reached.',
  '503': 'Resource currently unavailable. Try again later.',
  '529': 'Too many requests. Please wait and resend your request.',
  '5**': 'Internal error',
};

class DeepLTranslationEngine extends TranslationEngine {
  DeepLTranslationEngine({
    required String identifier,
    Map<String, dynamic>? option,
  }) : super(identifier: identifier, option: option);
  static List<String> optionKeys = [
    _kEngineOptionKeyAuthKey,
  ];

  @override
  String get type => kEngineTypeDeepL;

  @override
  List<TranslationEngineScope> get supportedScopes {
    return [
      TranslationEngineScope.translate,
    ];
  }

  bool get _isDeepLFree => _optionAuthKey.endsWith(':fx');
  String get _optionAuthKey => option?[_kEngineOptionKeyAuthKey] ?? '';

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

    Map<String, String> queryParameters = {
      'auth_key': _optionAuthKey,
      'text': request.text,
      'source_lang': request.sourceLanguage!.toUpperCase(),
      'target_lang': request.targetLanguage!.toUpperCase(),
    };

    String host = _isDeepLFree ? 'api-free.deepl.com' : 'api.deepl.com';
    var uri = Uri.https(host, '/v2/translate', queryParameters);

    var response = await http.post(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
    });

    String? errorMessage;

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

      if (data['translations'] != null) {
        Iterable l = data['translations'] as List;
        translations = l
            .map((e) => TextTranslation(
                  detectedSourceLanguage: e['detected_source_language'],
                  text: e['text'],
                ))
            .toList();
      }

      if (data['message'] != null) {
        errorMessage = [
          data['message'],
          data['detail'] ?? '',
        ].join('\n');
      }
    } else {
      errorMessage = _knownErrors['5**'];
      if (_knownErrors.containsKey('${response.statusCode}')) {
        errorMessage = _knownErrors['${response.statusCode}'];
      }
    }

    if ((errorMessage ?? '').trim().isNotEmpty) {
      throw UniTranslateClientError(
        message: errorMessage!,
      );
    }

    return TranslateResponse(
      translations: translations,
    );
  }
}
