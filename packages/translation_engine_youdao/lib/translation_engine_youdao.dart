library translation_engine_youdao;

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:translation_engine_youdao/youdao_api_known_errors.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

const String kEngineTypeYoudao = 'youdao';

const String _kEngineOptionKeyAppKey = 'appKey';
const String _kEngineOptionKeyAppSecret = 'appSecret';

String _md5(String data) {
  return md5.convert(utf8.encode(data)).toString();
}

String _sha256(String data) {
  return sha256.convert(utf8.encode(data)).toString();
}

class YoudaoTranslationEngine extends TranslationEngine {
  YoudaoTranslationEngine({
    required String identifier,
    Map<String, dynamic>? option,
  }) : super(identifier: identifier, option: option);

  static List<String> optionKeys = [
    _kEngineOptionKeyAppKey,
    _kEngineOptionKeyAppSecret,
  ];

  @override
  String get type => kEngineTypeYoudao;

  @override
  List<TranslationEngineScope> get supportedScopes {
    return [
      TranslationEngineScope.lookUp,
    ];
  }

  String get _optionAppKey => option?[_kEngineOptionKeyAppKey] ?? '';
  String get _optionAppSecret => option?[_kEngineOptionKeyAppSecret] ?? '';

  @override
  Future<DetectLanguageResponse> detectLanguage(DetectLanguageRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<LookUpResponse> lookUp(LookUpRequest request) async {
    List<TextTranslation> translations = [];
    String? word;
    String? tip;
    List<WordTag>? tags;
    List<WordDefinition>? definitions;
    List<WordPronunciation>? pronunciations;
    List<WordImage>? images;
    List<WordPhrase>? phrases;
    List<WordTense>? tenses;
    List<WordSentence>? sentences;

    String q = request.word;
    String input = q;
    if (q.length > 20) {
      input = '${q.substring(0, 10)}${q.length}${q.substring(q.length - 10)}';
    }

    final curtime = (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    final salt = _md5('translation_engine_youdao');
    final sign = _sha256('$_optionAppKey$input$salt$curtime$_optionAppSecret');

    Uri uri = Uri.https(
      'openapi.youdao.com',
      '/api',
      {
        'q': request.word,
        'from': request.sourceLanguage ?? 'auto',
        'to': request.targetLanguage,
        'appKey': _optionAppKey,
        'salt': salt.toString(),
        'sign': sign.toString(),
        'signType': 'v3',
        'curtime': '$curtime',
      },
    );

    var response = await http.get(uri);
    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    if (data['errorCode'] != '0') {
      String errorCode = data['errorCode'];
      String errorMessage = 'ErrorCode: $errorCode';
      if (youdaoApiKnownErrors.containsKey(errorCode)) {
        errorMessage = youdaoApiKnownErrors[errorCode]!;
      }
      throw UniTranslateClientError(message: errorMessage);
    }

    // var query = data['query'];
    var translation = data['translation'];
    var basic = data['basic'];
    var returnPhrase = data['returnPhrase'];
    var tSpeakUrl = data['tSpeakUrl'];

    if (translation != null) {
      translations =
          (translation as List).map((v) => TextTranslation(text: v)).toList();
      if (translations.length == 1) {
        translations[0] = translations[0].copyWith(audioUrl: tSpeakUrl);
      }
    }

    if (returnPhrase != null) {
      word = returnPhrase[0];
    }

    if (basic != null) {
      var examType = basic['exam_type'];
      var explains = basic['explains'];
      var wfs = basic['wfs'];

      if (examType != null) {
        tags = (examType as List).map((e) {
          return WordTag(name: e);
        }).toList();
      }
      if (explains != null) {
        definitions = (explains as List).map((e) {
          String def = e.toString();
          int dotIndex = def.indexOf('. ');
          String? name = dotIndex >= 0 ? def.substring(0, dotIndex + 1) : null;
          String value = dotIndex >= 0 ? def.substring(dotIndex + 2) : def;
          List<String> values = value.split('；');

          return WordDefinition(
            name: name,
            values: values,
          );
        }).toList();
      }

      pronunciations = [
        WordPronunciation(
            type: 'uk',
            phoneticSymbol: basic['uk-phonetic'],
            audioUrl: basic['uk-speech']),
        WordPronunciation(
            type: 'us',
            phoneticSymbol: basic['us-phonetic'],
            audioUrl: basic['us-speech']),
      ]
          .where((e) =>
              (e.phoneticSymbol ?? '').isNotEmpty ||
              (e.audioUrl ?? '').isNotEmpty)
          .toList();

      if (wfs != null) {
        tenses = (wfs as List).map((e) {
          var wf = e['wf'];
          String name = wf['name'];
          String value = wf['value'];

          List<String> values = [value];
          if (value.contains('或')) {
            values = value.split('或');
          }

          return WordTense(
            name: name,
            values: values,
          );
        }).toList();
      }
    }

    if ((definitions ?? []).isNotEmpty || (pronunciations ?? []).isNotEmpty) {
      Uri uri2 = Uri.https(
        'picdict.youdao.com',
        '/search',
        {
          'q': request.word,
          'le': request.sourceLanguage,
        },
      );

      try {
        var response2 = await http.get(uri2);
        Map<String, dynamic> data2 = json.decode(response2.body);

        if (data2['data']['pic'] != null) {
          images = (data2['data']['pic'] as List)
              .map((e) => WordImage(url: e['url']))
              .toList();
        }
      } catch (error) {
        // skip
      }
    }

    return LookUpResponse(
      translations: translations,
      word: word,
      tip: tip,
      tags: tags,
      definitions: definitions,
      pronunciations: pronunciations,
      images: images,
      phrases: phrases,
      tenses: tenses,
      sentences: sentences,
    );
  }

  @override
  Future<TranslateResponse> translate(TranslateRequest request) {
    throw UnimplementedError();
  }
}
