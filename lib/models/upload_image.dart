import 'package:merchant_gerbook_flutter/models/user.dart';

part '../parts/upload_image.dart';

class UploadImage {
  String? id;
  User? user;
  String? url;
  String? createdAt;
  String? updatedAt;
  String? blurhash;

  UploadImage({
    this.id,
    this.user,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.blurhash,
  });
  static $fromJson(Map<String, dynamic> json) => _$UploadImageFromJson(json);

  factory UploadImage.fromJson(Map<String, dynamic> json) =>
      _$UploadImageFromJson(json);
  Map<String, dynamic> toJson() => _$UploadImageToJson(this);
}
