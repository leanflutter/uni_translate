import 'package:json_annotation/json_annotation.dart';

part 'uni_translate_client_error.g.dart';

@JsonSerializable()
class UniTranslateClientError implements Exception {
  UniTranslateClientError({
    this.code,
    required this.message,
  });

  factory UniTranslateClientError.fromJson(Map<String, dynamic> json) =>
      _$UniTranslateClientErrorFromJson(json);

  final String? code;
  final String message;

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    }..removeWhere((key, value) => value == null);
  }
}
