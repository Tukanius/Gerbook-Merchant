part of '../models/camp_create_model.dart';

CampCreateModel _$CampCreateModelFromJson(Map<String, dynamic> json) {
  return CampCreateModel(
    name: json['name'] != null ? json['name'] as String : null,
    images: json['images'] != null
        ? (json['images'] as List).map((e) => e as String).toList()
        : null,
    mainImage: json['mainImage'] != null ? json['mainImage'] as String : null,
    longitude: json['longitude'] != null ? json['longitude'] as num : null,
    latitude: json['latitude'] != null ? json['latitude'] as num : null,
    discount: json['discount'] != null
        ? (json['discount'] as List).map((e) => e as String).toList()
        : null,
    level0: json['level0'] != null ? json['level0'] as String : null,
    level1: json['level1'] != null ? json['level1'] as String : null,
    level2: json['level2'] != null ? json['level2'] as String : null,
    level3: json['level3'] != null ? json['level3'] as String : null,
    additionalInformation: json['additionalInformation'] != null
        ? json['additionalInformation'] as String
        : null,
    placeOffers: json['placeOffers'] != null
        ? (json['placeOffers'] as List).map((e) => e as String).toList()
        : null,
    discounts: json['discounts'] != null
        ? (json['discounts'] as List)
              .map((e) => DiscountTypes.fromJson(e))
              .toList()
        : null,
    cancelPolicies: json['cancelPolicies'] != null
        ? (json['cancelPolicies'] as List)
              .map((e) => CancelPolicy.fromJson(e))
              .toList()
        : null,
    checkInTime: json['checkInTime'] != null
        ? json['checkInTime'] as String
        : null,
    checkOutTime: json['checkOutTime'] != null
        ? json['checkOutTime'] as String
        : null,
    tags: json['tags'] != null
        ? (json['tags'] as List).map((e) => e as String).toList()
        : null,
    isOpenYearRound: json['isOpenYearRound'] != null
        ? json['isOpenYearRound'] as bool
        : null,
    zone: json['zone'] != null ? json['zone'] as String : null,
    travelOffers: json['travelOffers'] != null
        ? (json['travelOffers'] as List)
              .map((e) => TravelOffers.fromJson(e))
              .toList()
        : null,

    properties: json['properties'] != null
        ? (json['properties'] as List)
              .map((e) => CreateCampProperty.fromJson(e))
              .toList()
        : null,
    description: json['description'] != null
        ? json['description'] as String
        : null,
  );
}

Map<String, dynamic> _$CampCreateModelToJson(CampCreateModel instance) {
  Map<String, dynamic> json = {};
  if (instance.name != null) json['name'] = instance.name;
  if (instance.images != null) json['images'] = instance.images;
  if (instance.mainImage != null) json['mainImage'] = instance.mainImage;
  if (instance.longitude != null) json['longitude'] = instance.longitude;
  if (instance.latitude != null) json['latitude'] = instance.latitude;
  if (instance.discount != null) json['discount'] = instance.discount;
  if (instance.level0 != null) json['level0'] = instance.level0;
  if (instance.level1 != null) json['level1'] = instance.level1;
  if (instance.level2 != null) json['level2'] = instance.level2;
  if (instance.level3 != null) json['level3'] = instance.level3;
  if (instance.additionalInformation != null)
    json['additionalInformation'] = instance.additionalInformation;
  if (instance.placeOffers != null) json['placeOffers'] = instance.placeOffers;
  if (instance.discounts != null) json['discounts'] = instance.discounts;
  if (instance.cancelPolicies != null)
    json['cancelPolicies'] = instance.cancelPolicies;
  if (instance.checkInTime != null) json['checkInTime'] = instance.checkInTime;
  if (instance.checkOutTime != null)
    json['checkOutTime'] = instance.checkOutTime;
  if (instance.tags != null) json['tags'] = instance.tags;
  if (instance.isOpenYearRound != null)
    json['isOpenYearRound'] = instance.isOpenYearRound;
  if (instance.zone != null) json['zone'] = instance.zone;
  if (instance.travelOffers != null)
    json['travelOffers'] = instance.travelOffers;
  if (instance.properties != null) json['properties'] = instance.properties;
  if (instance.description != null) json['description'] = instance.description;
  return json;
}
