import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:uni_translate_client/src/models/text_translation.dart';

part 'translate_response.g.dart';

@JsonSerializable()
class TranslateResponse {
  const TranslateResponse({
    this.translations = const [],
  });

  factory TranslateResponse.fromJson(Map<String, dynamic> json) =>
      _$TranslateResponseFromJson(json);

  final List<TextTranslation> translations;

  Map<String, dynamic> toJson() => _$TranslateResponseToJson(this);
}

class StreamTranslateResponse extends TranslateResponse {
  StreamTranslateResponse({
    List<TextTranslation> translations = const [],
    this.streamController,
  })  : _translations = translations,
        super(translations: []);

  final StreamController<TranslateResponse>? streamController;

  List<TextTranslation> _translations;

  @override
  List<TextTranslation> get translations => _translations;

  set translations(List<TextTranslation> value) {
    _translations = value;
    if (streamController != null) {
      streamController!.add(this);
    }
  }

  bool get generating {
    if (streamController == null) {
      return false;
    }
    return !streamController!.isClosed;
  }

  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  EventSink<TranslateResponse> get sink => streamController!.sink;

  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  Stream<TranslateResponse> get stream => streamController!.stream;
}
