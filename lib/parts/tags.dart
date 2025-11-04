part of '../models/tags.dart';

Tags _$TagsFromJson(Map<String, dynamic> json) {
  return Tags(
    id: json['_id'] != null ? json['_id'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    sort: json['sort'] != null ? json['sort'] as num : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    icon: json['icon'] != null ? json['icon'] as String : null,
    selectedIcon:
        json['selectedIcon'] != null ? json['selectedIcon'] as String : null,
    count: json['count'] != null ? json['count'] as int : null,
  );
}

Map<String, dynamic> _$TagsToJson(Tags instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.sort != null) json['sort'] = instance.sort;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.icon != null) json['icon'] = instance.icon;
  if (instance.count != null) json['count'] = instance.count;
  if (instance.selectedIcon != null)
    json['selectedIcon'] = instance.selectedIcon;

  return json;
}
