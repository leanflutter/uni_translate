class WordTag {
  String name;

  WordTag({this.name});

  factory WordTag.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return WordTag(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    }..removeWhere((key, value) => value == null);
  }
}
