import 'translation_engine.dart';
import 'uni_translate_client_adapter.dart';

class UniTranslateClient {
  final UniTranslateClientAdapter adapter;

  UniTranslateClient(this.adapter);

  TranslationEngine get firstEngine {
    return adapter.first;
  }

  TranslationEngine use(String identifier) {
    return adapter.use(identifier);
  }
}
