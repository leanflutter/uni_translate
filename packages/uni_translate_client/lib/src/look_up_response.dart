import 'package:json_annotation/json_annotation.dart';
import 'package:uni_translate_client/src/models/text_translation.dart';
import 'package:uni_translate_client/src/models/word_definition.dart';
import 'package:uni_translate_client/src/models/word_image.dart';
import 'package:uni_translate_client/src/models/word_phrase.dart';
import 'package:uni_translate_client/src/models/word_pronunciation.dart';
import 'package:uni_translate_client/src/models/word_sentence.dart';
import 'package:uni_translate_client/src/models/word_tag.dart';
import 'package:uni_translate_client/src/models/word_tense.dart';
import 'package:uni_translate_client/src/translate_response.dart';

part 'look_up_response.g.dart';

@JsonSerializable()
class LookUpResponse extends TranslateResponse {
  const LookUpResponse({
    super.translations,
    this.word,
    this.tip,
    this.tags,
    this.definitions,
    this.pronunciations,
    this.images,
    this.phrases,
    this.tenses,
    this.sentences,
  });

  factory LookUpResponse.fromJson(Map<String, dynamic> json) =>
      _$LookUpResponseFromJson(json);

  final String? word; // 单词
  final String? tip; // 提示
  final List<WordTag>? tags; // 标签
  final List<WordDefinition>? definitions; // 定义（基本释义）
  final List<WordPronunciation>? pronunciations; // 发音
  final List<WordImage>? images; // 图片
  final List<WordPhrase>? phrases; // 短语
  final List<WordTense>? tenses; // 时态
  final List<WordSentence>? sentences; // 例句

  @override
  Map<String, dynamic> toJson() => _$LookUpResponseToJson(this);
}
