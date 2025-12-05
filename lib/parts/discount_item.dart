part of '../models/discount_item.dart';

DiscountItem _$DiscountItemFromJson(Map<String, dynamic> json) {
  return DiscountItem(
    id: json['_id'] != null ? json['_id'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    value: json['value'] != null ? json['value'] as int : null,
  );
}

Map<String, dynamic> _$DiscountItemToJson(DiscountItem instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;

  if (instance.type != null) json['type'] = instance.type;
  if (instance.value != null) json['value'] = instance.value;

  return json;
}
