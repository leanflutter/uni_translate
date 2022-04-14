class UniTranslateClientError implements Exception {
  final String? code;
  final String message;

  UniTranslateClientError({
    this.code,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': this.code,
      'message': this.message,
    }..removeWhere((key, value) => value == null);
  }
}
