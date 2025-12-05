part of '../models/special_dates.dart';

SpecialDates _$SpecialDatesFromJson(Map<String, dynamic> json) {
  return SpecialDates(
    id: json['_id'] != null ? json['_id'] as String : null,
    date: json['date'] != null ? json['date'] as String : null,
    price: json['price'] != null ? json['price'] as num : null,
  );
}

Map<String, dynamic> _$SpecialDatesToJson(SpecialDates instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.date != null) json['date'] = instance.date;
  if (instance.price != null) json['price'] = instance.price;

  return json;
}
