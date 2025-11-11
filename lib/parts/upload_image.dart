part of '../models/upload_image.dart';

UploadImage _$UploadImageFromJson(Map<String, dynamic> json) {
  return UploadImage(
    id: json['_id'] != null ? json['_id'] as String : null,
    user: json['user'] != null ? User.fromJson(json['user']) : null,
    url: json['url'] != null ? json['url'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    blurhash: json['blurhash'] != null ? json['blurhash'] as String : null,
  );
}

Map<String, dynamic> _$UploadImageToJson(UploadImage instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.user != null) json['user'] = instance.user;
  if (instance.url != null) json['url'] = instance.url;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.blurhash != null) json['blurhash'] = instance.blurhash;

  return json;
}
