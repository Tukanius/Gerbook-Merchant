part of '../models/travel_offers_data.dart';

TravelOffersData _$TravelOffersDataFromJson(Map<String, dynamic> json) {
  return TravelOffersData(
    id: json['_id'] != null ? json['_id'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    sort: json['sort'] != null ? json['sort'] as int : null,
  );
}

Map<String, dynamic> _$TravelOffersDataToJson(TravelOffersData instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.sort != null) json['sort'] = instance.sort;

  return json;
}
