import 'package:uni_translate_client/src/translation_engine.dart';

class DefaultUniTranslateClientAdapter extends UniTranslateClientAdapter {
  DefaultUniTranslateClientAdapter(this.engines);
  final List<TranslationEngine> engines;

  @override
  TranslationEngine get first {
    return engines.first;
  }

  @override
  TranslationEngine use(String identifier) {
    return engines.firstWhere((e) => e.identifier == identifier);
  }
}

abstract class UniTranslateClientAdapter {
  TranslationEngine get first;
  TranslationEngine use(String identifier);
}
