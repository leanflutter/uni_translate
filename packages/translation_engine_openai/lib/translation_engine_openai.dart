library translation_engine_openai;

import 'dart:async';

import 'package:dart_openai/dart_openai.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

const String kEngineTypeOpenAI = 'openai';

const String _kEngineOptionKeyBaseUrl = 'baseUrl';
const String _kEngineOptionKeyApiKey = 'apiKey';
const String _kEngineOptionKeyPrompt = 'prompt';

const String _kDefaultPrompt =
    'You are a translation engine that can only translate text and cannot interpret it. '
    'translate from \${sourceLanguage} to \${targetLanguage}';

class OpenAITranslationEngine extends TranslationEngine {
  OpenAITranslationEngine({
    required String identifier,
    Map<String, dynamic>? option,
  }) : super(identifier: identifier, option: option);

  static List<String> optionKeys = [
    _kEngineOptionKeyBaseUrl,
    _kEngineOptionKeyApiKey,
    _kEngineOptionKeyPrompt,
  ];

  @override
  String get type => kEngineTypeOpenAI;
  @override
  List<String> get supportedScopes => [kScopeTranslate];

  String get _optionBaseUrl => option?[_kEngineOptionKeyBaseUrl] ?? '';
  String get _optionApiKey => option?[_kEngineOptionKeyApiKey] ?? '';
  String get _optionPrompt =>
      option?[_kEngineOptionKeyPrompt] ?? _kDefaultPrompt;

  @override
  Future<DetectLanguageResponse> detectLanguage(DetectLanguageRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<LookUpResponse> lookUp(LookUpRequest request) async {
    throw UnimplementedError();
  }

  @override
  Future<TranslateResponse> translate(TranslateRequest request) async {
    Completer<TranslateResponse> completer = Completer<TranslateResponse>();

    TranslateResponse translateResponse = TranslateResponse()
      ..generating = true;

    OpenAI.apiKey = _optionApiKey;
    if (_optionBaseUrl.isNotEmpty) {
      OpenAI.baseUrl = _optionBaseUrl;
    }

    final chatCompletionModel = OpenAI.instance.chat.createStream(
      model: 'gpt-3.5-turbo',
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.system,
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
              _optionPrompt
                  .replaceFirst('\${sourceLanguage}', request.sourceLanguage!)
                  .replaceFirst('\${targetLanguage}', request.targetLanguage!),
            ),
          ],
        ),
        OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.user,
          content: [
            OpenAIChatCompletionChoiceMessageContentItemModel.text(
              request.text,
            ),
          ],
        )
      ],
    );

    String translatedText = '';
    chatCompletionModel.listen(
      (streamChatCompletion) {
        final content = streamChatCompletion.choices.first.delta.content;
        if (content == null || content.isEmpty) return;
        translatedText += content.first.text!;

        TextTranslation textTranslation;
        if (translateResponse.translations == null) {
          textTranslation = TextTranslation(text: translatedText);
          translateResponse.translations = [textTranslation];
          completer.complete(translateResponse);
        } else {
          textTranslation = translateResponse.translations!.first;
          textTranslation.text = translatedText;
        }
        translateResponse.sink.add(translateResponse);
      },
      onDone: () {
        translateResponse.generating = false;
        translateResponse.sink.add(translateResponse);
        translateResponse.sink.close();
      },
      onError: (Object error, StackTrace stackTrace) {
        translateResponse.generating = false;
        translateResponse.sink.add(translateResponse);
        translateResponse.sink.addError(error, stackTrace);
        if (!completer.isCompleted) {
          completer.completeError(error, stackTrace);
        }
        translateResponse.sink.close();
      },
      cancelOnError: true,
    );
    return completer.future;
  }
}
