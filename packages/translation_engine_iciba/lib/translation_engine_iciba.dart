library translation_engine_iciba;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:uni_translate_client/uni_translate_client.dart';

const String kEngineTypeIciba = 'iciba';

const String _kEngineOptionKeyApiKey = 'apiKey';

class IcibaTranslationEngine extends TranslationEngine {
  IcibaTranslationEngine({
    required String identifier,
    Map<String, dynamic>? option,
  }) : super(identifier: identifier, option: option);

  static List<String> optionKeys = [
    _kEngineOptionKeyApiKey,
  ];

  @override
  String get type => kEngineTypeIciba;

  @override
  List<TranslationEngineScope> get supportedScopes {
    return [
      TranslationEngineScope.lookUp,
    ];
  }

  String get _optionApiKey => option?[_kEngineOptionKeyApiKey] ?? '';

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

    if (!(request.sourceLanguage == 'en' && request.targetLanguage == 'zh')) {
      throw UniTranslateClientError(message: 'Not Supported');
    }

    Uri uri = Uri.http(
      'dict-co.iciba.com',
      '/api/dictionary.php',
      {
        'w': request.word.toLowerCase(),
        'key': _optionApiKey,
        'type': 'json',
      },
    );

    var response = await http.get(uri);
    if (response.headers[HttpHeaders.contentTypeHeader]?.contains('text/xml') ==
        true) {
      throw UniTranslateClientError(message: 'Please check your key');
    }

    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    word = data['word_name'];

    var symbol = data['symbols'][0];
    var parts = symbol['parts'];

    if (parts != null) {
      definitions = (parts as List).map((e) {
        String name = e['part'];
        List<String> values =
            (e['means'] as List).map((e) => e.toString()).toList();

        return WordDefinition(
          name: name,
          values: values,
        );
      }).toList();

      pronunciations = [
        WordPronunciation(
          type: 'uk',
          phoneticSymbol: symbol['ph_en'],
          audioUrl: symbol['ph_en_mp3'],
        ),
        WordPronunciation(
          type: 'us',
          phoneticSymbol: symbol['ph_am'],
          audioUrl: symbol['ph_am_mp3'],
        ),
      ]
          .where((e) =>
              (e.phoneticSymbol ?? '').isNotEmpty ||
              (e.audioUrl ?? '').isNotEmpty)
          .toList();
    }

    if (data['exchange'] != null) {
      Map<String, String> map = {
        'word_pl': '复数',
        'word_third': '第三人称单数',
        'word_past': '过去式',
        'word_done': '过去分词',
        'word_ing': '现在分词',
        'word_er': 'word_er',
        'word_est': 'word_est',
      };
      tenses = (data['exchange'] as Map)
          .keys
          .map((k) {
            String name = map[k] ?? '';
            dynamic value = (data['exchange'][k]);
            List<String> values = [];

            if (value is List) {
              values = (value).map((e) => e.toString()).toList();
            }

            return WordTense(
              name: name,
              values: values,
            );
          })
          .where((e) => (e.values ?? []).isNotEmpty)
          .toList();

      if (tenses.isEmpty) {
        tenses = null;
      }
    }

    if ((pronunciations ?? []).isEmpty && (definitions ?? []).isEmpty) {
      throw UniTranslateClientError(message: 'Resource not found.');
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
  Future<TranslateResponse> translate(TranslateRequest request) async {
    throw UnimplementedError();
  }
}
