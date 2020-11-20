library translation_engine_sogou;

import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:uni_translate_client/uni_translate_client.dart';

const String kEngineTypeSogou = 'sogou';

const String _kEngineOptionKeyPid = 'pid';
const String _kEngineOptionKeyKey = 'key';

String _md5(String data) {
  return md5.convert(utf8.encode(data)).toString();
}

class SogouTranslationEngine extends TranslationEngine {
  static List<String> optionKeys = [
    _kEngineOptionKeyPid,
    _kEngineOptionKeyKey,
  ];

  SogouTranslationEngine(TranslationEngineConfig config) : super(config);

  String get type => kEngineTypeSogou;
  List<String> get supportedScopes => [kScopeLookUp];

  String get _optionPid => option[_kEngineOptionKeyPid];
  String get _optionKey => option[_kEngineOptionKeyKey];

  String _convertLanguageCode(String languageCode) {
    Map<String, String> map = {
      'zh': 'zh-CHS',
    };

    if (map.containsKey(languageCode)) {
      return map[languageCode];
    }
    return languageCode;
  }

  @override
  Future<DetectLanguageResponse> detectLanguage(DetectLanguageRequest request) {
    // TODO: implement detectLanguage
    throw UnimplementedError();
  }

  @override
  Future<LookUpResponse> lookUp(LookUpRequest request) async {
    LookUpResponse lookUpResponse = LookUpResponse();

    String q = request.word;

    final from = _convertLanguageCode(request.sourceLanguage) ?? 'auto';
    final to = _convertLanguageCode(request.targetLanguage);
    final curtime = (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    final salt = Random().nextInt(999999);
    final sign = _md5('$_optionPid$q$salt$_optionKey');

    Uri uri = Uri.http(
      'fanyi.sogou.com',
      '/reventondc/api/sogouTranslate',
      {
        'q': request.word,
        'from': from,
        'to': to,
        'pid': _optionPid,
        'salt': salt.toString(),
        'sign': sign.toString(),
        'dict': 'true',
      },
    );

    var response = await http.post(uri, headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    });
    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    lookUpResponse.word = data['query'];
    if (data['translation'] != null) {
      lookUpResponse.translations = [
        TextTranslation(text: data['translation']),
      ];
    }

    if (data['usual'] != null) {
      var usual = data['usual'];

      lookUpResponse.definitions = (usual as List).map((e) {
        String name = e['pos'];
        List<String> values =
            (e['values'] as List).map((e) => e.toString()).toList();

        return WordDefinition(
          name: name,
          values: values,
        );
      }).toList();
    }

    if (data['phonetic'] != null) {
      lookUpResponse.pronunciations = (data['phonetic'] as List).map((e) {
        String type = e['type'];
        if (type == 'usa') type = 'us';
        return WordPronunciation(
          type: type,
          phoneticSymbol: e['text'],
          audioUrl: e['filename'],
        );
      }).toList();
    }

    return lookUpResponse;
  }

  @override
  Future<TranslateResponse> translate(TranslateRequest request) {
    throw UnimplementedError();
  }
}
