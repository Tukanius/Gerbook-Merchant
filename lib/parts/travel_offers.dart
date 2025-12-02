part of '../models/travel_offers.dart';

TravelOffers _$TravelOffersFromJson(Map<String, dynamic> json) {
  return TravelOffers(
    id: json['_id'] != null ? json['_id'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    price: json['price'] != null ? json['price'] as num : null,
    maxQuantity: json['maxQuantity'] != null
        ? json['maxQuantity'] as num
        : null,
    travelOffer: json['travelOffer'] != null
        ? json['travelOffer'] as String
        : null,
  );
}

Map<String, dynamic> _$TravelOffersToJson(TravelOffers instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.price != null) json['price'] = instance.price;
  if (instance.maxQuantity != null) json['maxQuantity'] = instance.maxQuantity;
  if (instance.travelOffer != null) json['travelOffer'] = instance.travelOffer;

  return json;
}
