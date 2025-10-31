part '../parts/images.dart';

class Images {
  String? id;
  String? user;
  String? url;
  String? createdAt;
  String? updatedAt;
  String? blurhash;
  Images({
    this.id,
    this.user,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.blurhash,
  });
  static $fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}
