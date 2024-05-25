import 'package:uni_translate_client/src/detect_language_request.dart';
import 'package:uni_translate_client/src/detect_language_response.dart';
import 'package:uni_translate_client/src/look_up_request.dart';
import 'package:uni_translate_client/src/look_up_response.dart';
import 'package:uni_translate_client/src/models/language_pair.dart';
import 'package:uni_translate_client/src/translate_request.dart';
import 'package:uni_translate_client/src/translate_response.dart';
import 'package:uni_translate_client/src/translation_engine_scope.dart';

abstract class TranslationEngine {
  TranslationEngine({
    required this.identifier,
    this.option,
  });

  String get id => identifier;
  String get type => throw UnimplementedError();
  List<TranslationEngineScope> get supportedScopes =>
      throw UnimplementedError();

  String identifier;
  Map<String, dynamic>? option;
  bool disabled = false;

  Future<List<LanguagePair>> getSupportedLanguagePairs() {
    throw UnimplementedError();
  }

  Future<DetectLanguageResponse> detectLanguage(DetectLanguageRequest request);

  Future<LookUpResponse> lookUp(LookUpRequest request);

  Future<TranslateResponse> translate(TranslateRequest request);

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'type': type,
      'supportedScopes': supportedScopes.map((e) => e.name).toList(),
      'disabled': disabled,
    };
  }
}
