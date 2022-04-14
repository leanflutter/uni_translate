library translation_engine_tencent;

import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:uni_translate_client/uni_translate_client.dart';

const String kEngineTypeTencent = 'tencent';

const String _kEngineOptionKeySecretId = 'secretId';
const String _kEngineOptionKeySecretKey = 'secretKey';

String _signature(String key, String data) {
  var hmacSha1 = new Hmac(sha1, utf8.encode(key));
  var digest = hmacSha1.convert(utf8.encode(data));

  return base64.encode(digest.bytes).toString();
}

class TencentTranslationEngine extends TranslationEngine {
  static List<String> optionKeys = [
    _kEngineOptionKeySecretId,
    _kEngineOptionKeySecretKey,
  ];

  TencentTranslationEngine(TranslationEngineConfig config) : super(config);

  String get type => kEngineTypeTencent;
  List<String> get supportedScopes => [kScopeTranslate];

  String get _optionSecretId => option[_kEngineOptionKeySecretId];
  String get _optionSecretKey => option[_kEngineOptionKeySecretKey];

  @override
  Future<DetectLanguageResponse> detectLanguage(
      DetectLanguageRequest request) async {
    DetectLanguageResponse detectLanguageResponse = DetectLanguageResponse();

    Map<String, String> body = {
      'Action': 'LanguageDetect',
      'Language': 'zh-CN',
      'Nonce': '${Random().nextInt(9999)}',
      'ProjectId': '0',
      'Region': 'ap-guangzhou',
      'SecretId': _optionSecretId,
      'Text': request.texts.first,
      'Timestamp': '${DateTime.now().millisecondsSinceEpoch ~/ 1000}',
      'Version': '2018-03-21',
    };

    List<String> keys = body.keys.toList();
    keys.sort((a, b) => a.compareTo(b));
    String query = keys.map((key) => '$key=${body[key]}').join('&');

    String endpoint = 'tmt.tencentcloudapi.com';
    String srcStr = 'POST$endpoint/?${query}';
    String signature = _signature(_optionSecretKey, srcStr);

    body.putIfAbsent('Signature', () => signature);

    keys = body.keys.toList();
    keys.sort((a, b) => a.compareTo(b));
    query = keys.map((key) => '$key=${body[key]}').join('&');

    var response = await http.post(
      Uri.parse('https://$endpoint'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
      body: body,
    );

    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    detectLanguageResponse.detections = [
      TextDetection(
        detectedLanguage: data['Response']['Lang'],
        text: request.texts.first,
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

    Map<String, String> body = {
      'Action': 'TextTranslate',
      'Language': 'zh-CN',
      'Nonce': '${Random().nextInt(9999)}',
      'ProjectId': '0',
      'Region': 'ap-guangzhou',
      'SecretId': _optionSecretId,
      'Source': request.sourceLanguage ?? 'auto',
      'SourceText': request.text,
      'Target': request.targetLanguage!,
      'Timestamp': '${DateTime.now().millisecondsSinceEpoch ~/ 1000}',
      'Version': '2018-03-21',
    };

    List<String> keys = body.keys.toList();
    keys.sort((a, b) => a.compareTo(b));
    String query = keys.map((key) => '$key=${body[key]}').join('&');

    String endpoint = 'tmt.tencentcloudapi.com';
    String srcStr = 'POST$endpoint/?${query}';
    String signature = _signature(_optionSecretKey, srcStr);

    body.putIfAbsent('Signature', () => signature);

    keys = body.keys.toList();
    keys.sort((a, b) => a.compareTo(b));
    query = keys.map((key) => '$key=${body[key]}').join('&');

    var response = await http.post(
      Uri.parse('https://$endpoint'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
      body: body,
    );

    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    translateResponse.translations = [
      TextTranslation(text: data['Response']['TargetText']),
    ];

    return translateResponse;
  }
}
