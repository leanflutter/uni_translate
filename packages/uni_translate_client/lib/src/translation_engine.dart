import 'detect_language_request.dart';
import 'detect_language_response.dart';
import 'look_up_request.dart';
import 'look_up_response.dart';
import 'translate_request.dart';
import 'translate_response.dart';
import 'models/language_pair.dart';

const kScopeDetectLanguage = 'detectLanguage';
const kScopeLookUp = 'lookUp';
const kScopeTranslate = 'translate';

abstract class TranslationEngine {
  String get type => throw UnimplementedError();
  List<String> get supportedScopes => throw UnimplementedError();

  String identifier;
  Map<String, dynamic>? option;
  bool disabled = false;

  TranslationEngine({
    required this.identifier,
    this.option,
  });

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
      'supportedScopes': supportedScopes,
      'disabled': disabled,
    };
  }
}
