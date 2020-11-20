import 'package:test/test.dart';

import 'package:uni_translate_client/uni_translate_client.dart';

void main() {
  test('adds one to input values', () {
    final client = UniTranslateClient(DefaultUniTranslateClientAdapter([]));
    client.firstEngine.lookUp(LookUpRequest());
    client.firstEngine.translate(TranslateRequest());
  });
}
