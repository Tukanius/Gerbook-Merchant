part of '../models/discount_types.dart';

DiscountTypes _$DiscountTypesFromJson(Map<String, dynamic> json) {
  return DiscountTypes(
    id: json['_id'] != null ? json['_id'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    value: json['value'] != null ? json['value'] as num : null,
    procent: json['procent'] != null ? json['procent'] as num : null,
    rate: json['rate'] != null ? json['rate'] as num : null,
    discountType: json['discountType'] != null
        ? json['discountType'] as String
        : null,
  );
}

Map<String, dynamic> _$DiscountTypesToJson(DiscountTypes instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.value != null) json['value'] = instance.value;
  if (instance.procent != null) json['procent'] = instance.procent;
  if (instance.rate != null) json['rate'] = instance.rate;
  if (instance.discountType != null)
    json['discountType'] = instance.discountType;

  return json;
}
