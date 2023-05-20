import 'package:uni_translate_client/src/translation_engine.dart';
import 'package:uni_translate_client/src/uni_translate_client_adapter.dart';

class UniTranslateClient {
  UniTranslateClient(this.adapter);

  final UniTranslateClientAdapter adapter;

  TranslationEngine get firstEngine {
    return adapter.first;
  }

  TranslationEngine use(String identifier) {
    return adapter.use(identifier);
  }
}
