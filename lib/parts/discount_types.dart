part of '../models/discount_types.dart';

DiscountTypes _$DiscountTypesFromJson(Map<String, dynamic> json) {
  return DiscountTypes(
    id: json['_id'] != null ? json['_id'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    value: json['value'] != null ? json['value'] as num : null,
    procent: json['procent'] != null ? json['procent'] as num : null,
  );
}

Map<String, dynamic> _$DiscountTypesToJson(DiscountTypes instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.value != null) json['value'] = instance.value;
  if (instance.procent != null) json['procent'] = instance.procent;

  return json;
}
