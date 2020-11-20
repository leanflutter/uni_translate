class WordTense {
  String type;
  String name;
  List<String> values;

  WordTense({this.type, this.name, this.values});

  factory WordTense.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    List<String> values;

    if (json['values'] != null) {
      Iterable l = json['values'] as List;
      values = l.map((item) => item.toString()).toList();
    }

    return WordTense(
      type: json['type'],
      name: json['name'],
      values: values,
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
