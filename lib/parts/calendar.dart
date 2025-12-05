part of '../models/calendar.dart';

Calendar _$CalendarFromJson(Map<String, dynamic> json) {
  return Calendar(
    date: json['date'] != null ? json['date'] as String : null,
    price: json['price'] != null ? json['price'] as int : null,
    blockedQuantity: json['blockedQuantity'] != null
        ? json['blockedQuantity'] as int
        : null,
    // property: json['property'] != null
    //     ? Calendar.fromJson(json['property'])
    //     : null,
  );
}

Map<String, dynamic> _$CalendarToJson(Calendar instance) {
  Map<String, dynamic> json = {};
  if (instance.date != null) json['date'] = instance.date;
  if (instance.price != null) json['price'] = instance.price;
  if (instance.blockedQuantity != null)
    json['blockedQuantity'] = instance.blockedQuantity;

  return json;
}
