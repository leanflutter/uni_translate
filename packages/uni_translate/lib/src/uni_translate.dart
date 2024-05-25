import 'package:uni_translate/uni_translate.dart';

class UniTranslate {
  UniTranslate._();

  /// The shared instance of [UniTranslate].
  static final UniTranslate instance = UniTranslate._();

  final List<TranslationEngine> _engines = [];

  /// Registers a [TranslationEngine].
  void registerEngine(TranslationEngine engine) {
    _engines.add(engine);
  }

  /// Unregisters a [TranslationEngine].
  void unregisterEngine(TranslationEngine engine) {
    _engines.remove(engine);
  }

  /// Returns a list of registered [TranslationEngine]s.
  List<TranslationEngine> get engines => _engines;

  /// Returns a [TranslationEngine] by its [engineId].
  TranslationEngine use(String engineId) {
    return _engines.firstWhere((engine) => engine.id == engineId);
  }
}
