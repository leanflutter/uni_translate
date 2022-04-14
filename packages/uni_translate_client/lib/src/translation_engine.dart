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

class TranslationEngineConfig {
  final String identifier;
  String type;
  String name;
  Map<String, dynamic> option;
  List<String> supportedScopes;
  List<String> disabledScopes;
  bool disabled = false;

  String get shortId => identifier.substring(0, 4);

  TranslationEngineConfig({
    required this.identifier,
    required this.type,
    required this.name,
    required this.option,
    this.supportedScopes = const [],
    this.disabledScopes = const [],
    this.disabled = false,
  });

  factory TranslationEngineConfig.fromJson(Map<String, dynamic> json) {
    return TranslationEngineConfig(
      identifier: json['identifier'],
      type: json['type'],
      name: json['name'],
      option: Map<String, dynamic>.from(json['option'] ?? {}),
      supportedScopes: List<String>.from(json['supportedScopes'] ?? []),
      disabledScopes: List<String>.from(json['disabledScopes'] ?? []),
      disabled: json['disabled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'type': type,
      'option': option,
      'supportedScopes': supportedScopes,
      'disabledScopes': disabledScopes,
      'disabled': disabled,
    };
  }
}

abstract class TranslationEngine {
  TranslationEngineConfig config;

  String get identifier => config.identifier;
  String get type => config.type;
  String get name => config.name;
  Map<String, dynamic> get option => config.option;
  List<String> get supportedScopes => config.supportedScopes;
  List<String> get disabledScopes => config.disabledScopes;
  bool get disabled => config.disabled;

  TranslationEngine(this.config);

  Future<List<LanguagePair>> getSupportedLanguagePairs() {
    throw UnimplementedError();
  }

  Future<DetectLanguageResponse> detectLanguage(DetectLanguageRequest request);

  Future<LookUpResponse> lookUp(LookUpRequest request);

  Future<TranslateResponse> translate(TranslateRequest request);

  Map<String, dynamic> toJson() {
    return {
      'identifier': config.identifier,
      'type': type,
      'name': config.name,
      'supportedScopes': supportedScopes,
      'disabledScopes': disabledScopes,
      'disabled': disabled,
    };
  }
}
