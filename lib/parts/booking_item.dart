part of '../models/booking_item.dart';

BookingItem _$BookingItemFromJson(Map<String, dynamic> json) {
  return BookingItem(
    property: json['property'] != null
        ? Properties.fromJson(json['property'])
        : null,
    personCount: json['personCount'] != null
        ? json['personCount'] as num
        : null,
    quantity: json['quantity'] != null ? json['quantity'] as num : null,

    // property: json['property'] != null
    //     ? BookingItem.fromJson(json['property'])
    //     : null,
  );
}

Map<String, dynamic> _$BookingItemToJson(BookingItem instance) {
  Map<String, dynamic> json = {};
  if (instance.property != null) json['property'] = instance.property;
  if (instance.personCount != null) json['personCount'] = instance.personCount;
  if (instance.quantity != null) json['quantity'] = instance.quantity;

  // if (instance.property != null) json['property'] = instance.property;

  return json;
}
