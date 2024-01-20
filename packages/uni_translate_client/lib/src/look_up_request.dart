import 'package:json_annotation/json_annotation.dart';
import 'package:uni_translate_client/src/translate_request.dart';

part 'look_up_request.g.dart';

@JsonSerializable()
class LookUpRequest extends TranslateRequest {
  const LookUpRequest({
    required super.sourceLanguage,
    required super.targetLanguage,
    required this.word,
  }) : super(text: word);

  factory LookUpRequest.fromJson(Map<String, dynamic> json) =>
      _$LookUpRequestFromJson(json);

  final String word;

  @override
  Map<String, dynamic> toJson() => _$LookUpRequestToJson(this);
}
