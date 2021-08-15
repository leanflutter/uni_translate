import 'detect_language_request.dart';
import 'detect_language_response.dart';
import 'look_up_request.dart';
import 'look_up_response.dart';
import 'translate_request.dart';
import 'translate_response.dart';

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
    this.identifier,
    this.type,
    this.name,
    this.option,
    this.supportedScopes,
    this.disabledScopes,
    this.disabled = false,
  });

  factory TranslationEngineConfig.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return TranslationEngineConfig(
      identifier: json['identifier'],
      type: json['type'],
      name: json['name'],
      option: json['option'] != null
          ? Map<String, dynamic>.from(json['option'])
          : null,
      supportedScopes: json['supportedScopes'] != null
          ? List<String>.from(json['supportedScopes'])
          : null,
      disabledScopes: json['disabledScopes'] != null
          ? List<String>.from(json['disabledScopes'])
          : null,
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
      'disabled': disabled ?? false,
    };
  }
}

abstract class TranslationEngine {
  TranslationEngineConfig config;

  String get identifier => config.identifier;
  String get type => config.type;
  String get name => config.name;
  Map<String, dynamic> get option => config.option;
  List<String> get supportedScopes => config.supportedScopes ?? [];
  List<String> get disabledScopes => config.disabledScopes ?? [];
  bool get disabled => config.disabled ?? false;

  TranslationEngine(this.config);

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
