library translation_engine_baidu;

import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:uni_translate_client/uni_translate_client.dart';

const String kEngineTypeBaidu = 'baidu';

const String _kEngineOptionKeyAppId = 'appId';
const String _kEngineOptionKeyAppKey = 'appKey';

String _md5(String data) {
  return md5.convert(utf8.encode(data)).toString();
}

class BaiduTranslationEngine extends TranslationEngine {
  BaiduTranslationEngine({
    required String identifier,
    Map<String, dynamic>? option,
  }) : super(identifier: identifier, option: option);
  static List<String> optionKeys = [
    _kEngineOptionKeyAppId,
    _kEngineOptionKeyAppKey,
  ];

  @override
  String get type => kEngineTypeBaidu;
  @override
  List<String> get supportedScopes => [kScopeDetectLanguage, kScopeTranslate];

  String get _optionAppId => option?[_kEngineOptionKeyAppId] ?? '';
  String get _optionAppKey => option?[_kEngineOptionKeyAppKey] ?? '';

  String? _convertLanguageCode(String? languageCode) {
    Map<String, String> map = {
      // 'de': 'de',
      // 'en': 'en',
      'es': 'spa',
      'fr': 'fra',
      // 'it': 'it',
      'ja': 'jp',
      'ko': 'kor',
      // 'pt': 'pt',
      'ru': 'ru',
      // 'zh': 'zh',
    };

    if (map.containsKey(languageCode)) {
      return map[languageCode];
    }
    return languageCode;
  }

  @override
  Future<DetectLanguageResponse> detectLanguage(
    DetectLanguageRequest request,
  ) async {
    DetectLanguageResponse detectLanguageResponse = DetectLanguageResponse();

    String q = request.texts.first;

    final salt = Random().nextInt(999999);
    final sign = _md5('$_optionAppId$q$salt$_optionAppKey');

    Uri uri = Uri.https(
      'fanyi-api.baidu.com',
      '/api/trans/vip/language',
      {
        'q': q,
        'appid': _optionAppId,
        'salt': salt.toString(),
        'sign': sign.toString(),
      },
    );

    var response = await http.post(uri, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    });
    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    if (data['error_code'] != null && data['error_code'] != 0) {
      throw UniTranslateClientError(
        code: data['error_code'].toString(),
        message: data['error_msg'],
      );
    }

    detectLanguageResponse.detections = [
      TextDetection(
        detectedLanguage: data['data']['src'],
        text: q,
      ),
    ];

    return detectLanguageResponse;
  }

  @override
  Future<LookUpResponse> lookUp(LookUpRequest request) async {
    throw UnimplementedError();
  }

  @override
  Future<TranslateResponse> translate(TranslateRequest request) async {
    TranslateResponse translateResponse = TranslateResponse();

    String q = request.text;

    final salt = Random().nextInt(999999);
    final sign = _md5('$_optionAppId$q$salt$_optionAppKey');

    Uri uri = Uri.https(
      'fanyi-api.baidu.com',
      '/api/trans/vip/translate',
      {
        'q': request.text,
        'from': _convertLanguageCode(request.sourceLanguage) ?? 'auto',
        'to': _convertLanguageCode(request.targetLanguage),
        'appid': _optionAppId,
        'salt': salt.toString(),
        'sign': sign.toString(),
        'dict': '0',
      },
    );

    var response = await http.post(uri, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    });
    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    if (data['error_code'] != null && data['error_code'] != 0) {
      throw UniTranslateClientError(
        code: data['error_code'].toString(),
        message: data['error_msg'],
      );
    }

    translateResponse.translations = (data['trans_result'] as List).map((e) {
      return TextTranslation(
        text: e['dst'],
      );
    }).toList();

    return translateResponse;
  }
}
