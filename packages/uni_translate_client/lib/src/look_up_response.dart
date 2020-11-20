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

    return LookUpResponse(
      word: json['word'],
      tip: json['tip'],
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
