class WordTense {
  String type;
  String name;
  List<String> values;

  WordTense({this.type, this.name, this.values});

  factory WordTense.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return WordTense(
      type: json['type'],
      name: json['name'],
      values: List<String>.from(json['values']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'values': values,
    }..removeWhere((key, value) => value == null);
  }
}
