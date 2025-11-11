part of '../models/place_offers.dart';

PlaceOffers _$PlaceOffersFromJson(Map<String, dynamic> json) {
  return PlaceOffers(
    id: json['_id'] != null ? json['_id'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    appType: json['appType'] != null ? json['appType'] as String : null,
    image: json['image'] != null ? Images.fromJson(json['image']) : null,
    sort: json['sort'] != null ? json['sort'] as num : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$PlaceOffersToJson(PlaceOffers instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.appType != null) json['appType'] = instance.appType;
  if (instance.image != null) json['image'] = instance.image;
  if (instance.sort != null) json['sort'] = instance.sort;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
