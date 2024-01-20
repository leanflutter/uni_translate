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
  var hmacSha1 = Hmac(sha1, utf8.encode(key));
  var digest = hmacSha1.convert(utf8.encode(data));

  return base64.encode(digest.bytes).toString();
}

class TencentTranslationEngine extends TranslationEngine {
  TencentTranslationEngine({
    required String identifier,
    Map<String, dynamic>? option,
  }) : super(identifier: identifier, option: option);

  static List<String> optionKeys = [
    _kEngineOptionKeySecretId,
    _kEngineOptionKeySecretKey,
  ];

  @override
  String get type => kEngineTypeTencent;

  @override
  List<TranslationEngineScope> get supportedScopes {
    return [
      TranslationEngineScope.translate,
    ];
  }

  String get _optionSecretId => option?[_kEngineOptionKeySecretId] ?? '';
  String get _optionSecretKey => option?[_kEngineOptionKeySecretKey] ?? '';

  @override
  Future<DetectLanguageResponse> detectLanguage(
    DetectLanguageRequest request,
  ) async {
    List<TextDetection> detections = [];

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
    String srcStr = 'POST$endpoint/?$query';
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

    detections = [
      TextDetection(
        detectedLanguage: data['Response']['Lang'],
        text: request.texts.first,
      ),
    ];

    return DetectLanguageResponse(
      detections: detections,
    );
  }

  @override
  Future<LookUpResponse> lookUp(LookUpRequest request) async {
    throw UnimplementedError();
  }

  @override
  Future<TranslateResponse> translate(TranslateRequest request) async {
    List<TextTranslation> translations = [];

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
    String srcStr = 'POST$endpoint/?$query';
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

    if (data['Response']['Error'] != null) {
      throw UniTranslateClientError(
        code: data['Response']['Error']['Code'],
        message: data['Response']['Error']['Message'],
      );
    }
    translations = [
      TextTranslation(text: data['Response']['TargetText']),
    ];

    return TranslateResponse(
      translations: translations,
    );
  }
}
