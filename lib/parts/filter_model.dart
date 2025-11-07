part of '../models/filter_model.dart';

FilterModel _$FilterModelFromJson(Map<String, dynamic> json) {
  return FilterModel(
    count: json['count'] != null ? json['count'] as int : null,
    priceMin: json['priceMin'] != null ? json['priceMin'] as int : null,
    priceMax: json['priceMax'] != null ? json['priceMax'] as int : null,
    placeOffers: json['placeOffers'] != null
        ? (json['placeOffers'] as List)
              .map((e) => PlaceOffers.fromJson(e))
              .toList()
        : null,
    tags: json['tags'] != null
        ? (json['tags'] as List).map((e) => Tags.fromJson(e)).toList()
        : null,
  );
}

Map<String, dynamic> _$FilterModelToJson(FilterModel instance) {
  Map<String, dynamic> json = {};
  if (instance.count != null) json['count'] = instance.count;
  if (instance.priceMax != null) json['priceMax'] = instance.priceMax;
  if (instance.priceMin != null) json['priceMin'] = instance.priceMin;
  if (instance.placeOffers != null) json['placeOffers'] = instance.placeOffers;
  if (instance.tags != null) json['tags'] = instance.tags;

  return json;
}
