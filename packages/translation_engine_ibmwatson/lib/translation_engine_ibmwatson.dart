library translation_engine_ibmwatson;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uni_translate_client/uni_translate_client.dart';

const String kEngineTypeIBMWatson = 'ibmwatson';

const String _kEngineOptionKeyApiKey = 'apiKey';
const String _kEngineOptionKeyApiUrl = 'apiUrl';

String _base64(String data) {
  return base64.encode(utf8.encode(data)).toString();
}

class IBMWatsonTranslationEngine extends TranslationEngine {
  static List<String> optionKeys = [
    _kEngineOptionKeyApiKey,
    _kEngineOptionKeyApiUrl,
  ];

  IBMWatsonTranslationEngine({
    required String identifier,
    Map<String, dynamic>? option,
  }) : super(identifier: identifier, option: option);

  String get type => kEngineTypeIBMWatson;
  List<String> get supportedScopes => [kScopeTranslate];

  String get _optionApiKey => option?[_kEngineOptionKeyApiKey];
  String get _optionApiUrl => option?[_kEngineOptionKeyApiUrl];

  @override
  Future<DetectLanguageResponse> detectLanguage(DetectLanguageRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<LookUpResponse> lookUp(LookUpRequest request) async {
    throw UnimplementedError();
  }

  @override
  Future<TranslateResponse> translate(TranslateRequest request) async {
    TranslateResponse translateResponse = TranslateResponse();

    String modelId = '${request.sourceLanguage}-${request.targetLanguage}';

    Uri uri = Uri.parse('$_optionApiUrl/v3/translate?version=2018-05-01');

    var response = await http.post(
      uri,
      headers: {
        'Authorization': 'Basic ${_base64('apikey:$_optionApiKey')}',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'model_id': modelId,
        'text': [request.text],
      }),
    );

    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    translateResponse.translations = (data['translations'] as List).map((e) {
      return TextTranslation(text: e['translation']);
    }).toList();

    return translateResponse;
  }
}
