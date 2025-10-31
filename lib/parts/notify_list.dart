part of '../models/notify_list.dart';

NotifyList _$NotifyListFromJson(Map<String, dynamic> json) {
  return NotifyList(
    id: json['_id'] != null ? json['_id'] as String : null,
    user: json['user'] != null ? json['user'] as String : null,
    title: json['title'] != null ? json['title'] as String : null,
    description:
        json['description'] != null ? json['description'] as String : null,
    objectType:
        json['objectType'] != null ? json['objectType'] as String : null,
    object:
        json['object'] != null ? NotifyObject.fromJson(json['object']) : null,
    objectImage: json['objectImage'] != null
        ? Images.fromJson(json['objectImage'])
        : null,
    type: json['type'] != null ? json['type'] as String : null,
    hasGetItem: json['hasGetItem'] != null ? json['hasGetItem'] as bool : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
  );
}

Map<String, dynamic> _$NotifyListToJson(NotifyList instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.user != null) json['user'] = instance.user;
  if (instance.title != null) json['title'] = instance.title;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.objectType != null) json['objectType'] = instance.objectType;
  if (instance.object != null) json['object'] = instance.object;
  if (instance.objectImage != null) json['objectImage'] = instance.objectImage;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.hasGetItem != null) json['hasGetItem'] = instance.hasGetItem;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;

  return json;
}
