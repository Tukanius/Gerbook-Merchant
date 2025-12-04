part of '../models/travel_offers_detail.dart';

TravelOffersDetail _$TravelOffersDetailFromJson(Map<String, dynamic> json) {
  return TravelOffersDetail(
    travelOffer: json['travelOffer'] != null
        ? TravelOffersData.fromJson(json['travelOffer'])
        : null,

    price: json['price'] != null ? json['price'] as int : null,
    maxQuantity: json['maxQuantity'] != null
        ? json['maxQuantity'] as int
        : null,
    id: json['_id'] != null ? json['_id'] as String : null,
  );
}

Map<String, dynamic> _$TravelOffersDetailToJson(TravelOffersDetail instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.travelOffer != null) json['travelOffer'] = instance.travelOffer;
  if (instance.price != null) json['price'] = instance.price;
  if (instance.maxQuantity != null) json['maxQuantity'] = instance.maxQuantity;

  return json;
}
