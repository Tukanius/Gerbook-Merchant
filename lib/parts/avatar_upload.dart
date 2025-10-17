part of '../models/avatar_upload.dart';

Avatar _$AvatarFromJson(Map<String, dynamic> json) {
  return Avatar(
    id: json['_id'] != null ? json['_id'] as String : null,
    url: json['url'] != null ? json['url'] as String : null,
    blurhash: json['blurhash'] != null ? json['blurhash'] as String : null,
  );
}

Map<String, dynamic> _$AvatarToJson(Avatar instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.url != null) json['url'] = instance.url;
  if (instance.blurhash != null) json['blurhash'] = instance.blurhash;

  return json;
}
