part of '../models/blocked_dates.dart';

BlockedDates _$BlockedDatesFromJson(Map<String, dynamic> json) {
  return BlockedDates(
    id: json['_id'] != null ? json['_id'] as String : null,
    date: json['date'] != null ? json['date'] as String : null,
    quantity: json['quantity'] != null ? json['quantity'] as num : null,
  );
}

Map<String, dynamic> _$BlockedDatesToJson(BlockedDates instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.date != null) json['date'] = instance.date;
  if (instance.quantity != null) json['quantity'] = instance.quantity;

  return json;
}
