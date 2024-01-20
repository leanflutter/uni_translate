import 'package:json_annotation/json_annotation.dart';

part 'word_image.g.dart';

@JsonSerializable()
class WordImage {
  WordImage({
    required this.url,
  });

  factory WordImage.fromJson(Map<String, dynamic> json) =>
      _$WordImageFromJson(json);

  final String url;

  Map<String, dynamic> toJson() => _$WordImageToJson(this);
}
