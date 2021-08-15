import 'translate_response.dart';
import 'models/text_translation.dart';
import 'models/word_definition.dart';
import 'models/word_image.dart';
import 'models/word_phrase.dart';
import 'models/word_pronunciation.dart';
import 'models/word_sentence.dart';
import 'models/word_tense.dart';
import 'models/word_tag.dart';

class LookUpResponse extends TranslateResponse {
  String word; // 单词
  String tip; // 提示
  List<WordTag> tags; // 标签
  List<WordDefinition> definitions; // 定义（基本释义）
  List<WordPronunciation> pronunciations; // 发音
  List<WordImage> images; // 图片
  List<WordPhrase> phrases; // 短语
  List<WordTense> tenses; // 时态
  List<WordSentence> sentences; // 例句

  LookUpResponse({
    List<TextTranslation> translations,
    this.word,
    this.tip,
    this.tags,
    this.definitions,
    this.pronunciations,
    this.images,
    this.phrases,
    this.tenses,
    this.sentences,
  }) : super(
          translations: translations,
        );

  factory LookUpResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    List<TextTranslation> translations;
    List<WordTag> tags;
    List<WordDefinition> definitions;
    List<WordPronunciation> pronunciations;
    List<WordImage> images;
    List<WordPhrase> phrases;
    List<WordTense> tenses;
    List<WordSentence> sentences;

    if (json['translations'] != null) {
      Iterable l = json['translations'] as List;
      translations = l.map((item) => TextTranslation.fromJson(item)).toList();
    }
    if (json['tags'] != null) {
      Iterable l = json['tags'] as List;
      tags = l.map((item) => WordTag.fromJson(item)).toList();
    }
    if (json['definitions'] != null) {
      Iterable l = json['definitions'] as List;
      definitions = l.map((item) => WordDefinition.fromJson(item)).toList();
    }
    if (json['pronunciations'] != null) {
      Iterable l = json['pronunciations'] as List;
      pronunciations =
          l.map((item) => WordPronunciation.fromJson(item)).toList();
    }
    if (json['images'] != null) {
      Iterable l = json['images'] as List;
      images = l.map((item) => WordImage.fromJson(item)).toList();
    }
    if (json['phrases'] != null) {
      Iterable l = json['phrases'] as List;
      phrases = l.map((item) => WordPhrase.fromJson(item)).toList();
    }
    if (json['tenses'] != null) {
      Iterable l = json['tenses'] as List;
      tenses = l.map((item) => WordTense.fromJson(item)).toList();
    }
    if (json['sentences'] != null) {
      Iterable l = json['sentences'] as List;
      sentences = l.map((item) => WordSentence.fromJson(item)).toList();
    }

    return LookUpResponse(
      translations: translations,
      word: json['word'],
      tip: json['tip'],
      tags: tags,
      definitions: definitions,
      pronunciations: pronunciations,
      images: images,
      phrases: phrases,
      tenses: tenses,
      sentences: sentences,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'translations': translations?.map((e) => e.toJson())?.toList(),
      'word': word,
      'tip': tip,
      'tags': tags?.map((e) => e.toJson())?.toList(),
      'definitions': definitions?.map((e) => e.toJson())?.toList(),
      'pronunciations': pronunciations?.map((e) => e.toJson())?.toList(),
      'images': images?.map((e) => e.toJson())?.toList(),
      'phrases': phrases?.map((e) => e.toJson())?.toList(),
      'tenses': tenses?.map((e) => e.toJson())?.toList(),
      'sentences': sentences?.map((e) => e.toJson())?.toList(),
    }..removeWhere((key, value) => value == null);
  }
}
