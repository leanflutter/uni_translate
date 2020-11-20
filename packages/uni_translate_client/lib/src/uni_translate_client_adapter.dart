import 'translation_engine.dart';

class DefaultUniTranslateClientAdapter extends UniTranslateClientAdapter {
  final List<TranslationEngine> engines;

  DefaultUniTranslateClientAdapter(this.engines);

  TranslationEngine get first {
    return engines.first;
  }

  TranslationEngine use(String identifier) {
    return engines.firstWhere((e) => e.identifier == identifier);
  }
}

abstract class UniTranslateClientAdapter {
  TranslationEngine get first;
  TranslationEngine use(String identifier);
}
