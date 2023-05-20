library translation_engine_google;

import 'dart:convert';
import 'dart:io';

// import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:uni_translate_client/uni_translate_client.dart';

const String kEngineTypeGoogle = 'google';

const String _kEngineOptionKeyApiKey = 'apiKey';

class GoogleTranslationEngine extends TranslationEngine {
  GoogleTranslationEngine({
    required String identifier,
    Map<String, dynamic>? option,
  }) : super(identifier: identifier, option: option);

  static List<String> optionKeys = [
    _kEngineOptionKeyApiKey,
  ];

  @override
  String get type => kEngineTypeGoogle;
  @override
  List<String> get supportedScopes => [kScopeDetectLanguage, kScopeTranslate];

  String get _optionApiKey => option?[_kEngineOptionKeyApiKey] ?? '';

  @override
  Future<DetectLanguageResponse> detectLanguage(
    DetectLanguageRequest request,
  ) async {
    DetectLanguageResponse detectLanguageResponse = DetectLanguageResponse();

    var response = await http.post(
      Uri.https(
        'translation.googleapis.com',
        '/language/translate/v2/detect',
        {'key': _optionApiKey},
      ),
      body: json.encode({
        'q': request.texts.first,
      }),
      headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
      },
    );
    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode != 200) {
      throw UniTranslateClientError(
        code: data['error']['code'].toString(),
        message: data['error']['message'],
      );
    }

    try {
      detectLanguageResponse.detections =
          List.from(data['data']['detections'][0])
              .map(
                (e) => TextDetection(
                  detectedLanguage: e['language'],
                  text: request.texts.first,
                ),
              )
              .toList();
    } catch (error) {
      print(error);
    }

    return detectLanguageResponse;
  }

  @override
  Future<LookUpResponse> lookUp(LookUpRequest request) async {
    throw UnimplementedError();
  }

  @override
  Future<TranslateResponse> translate(TranslateRequest request) async {
    TranslateResponse translateResponse = TranslateResponse();

    var response = await http.post(
      Uri.https(
        'translation.googleapis.com',
        '/language/translate/v2',
        {'key': _optionApiKey},
      ),
      body: json.encode({
        'q': request.text,
        'source': request.sourceLanguage,
        'target': request.targetLanguage,
        'format': 'text',
      }),
      headers: {
        // HttpHeaders.authorizationHeader: 'Bearer $_optionApiKey',
        HttpHeaders.contentTypeHeader: ContentType.json.toString(),
      },
    );
    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    if (response.statusCode != 200) {
      throw UniTranslateClientError(
        code: data['error']['code'].toString(),
        message: data['error']['message'],
      );
    }

    translateResponse.translations = List.from(data['data']['translations'])
        .map((e) => TextTranslation(text: e['translatedText']))
        .toList();

    return translateResponse;
  }
}
