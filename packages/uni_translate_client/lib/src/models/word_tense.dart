class WordTense {
  WordTense({
    this.type,
    this.name,
    this.values,
  });
  factory WordTense.fromJson(Map<String, dynamic> json) {
    return WordTense(
      type: json['type'],
      name: json['name'],
      values: List<String>.from(json['values']),
    );
  }

  String? type;
  String? name;
  List<String>? values;

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'values': values,
    }..removeWhere((key, value) => value == null);
  }
}
