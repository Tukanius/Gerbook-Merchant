part of '../models/discount_detail.dart';

DiscountDetail _$DiscountDetailFromJson(Map<String, dynamic> json) {
  return DiscountDetail(
    discountType: json['discountType'] != null
        ? DiscountItem.fromJson(json['discountType'])
        : null,
    rate: json['rate'] != null ? json['rate'] as int : null,
    id: json['_id'] != null ? json['_id'] as String : null,
  );
}

Map<String, dynamic> _$DiscountDetailToJson(DiscountDetail instance) {
  Map<String, dynamic> json = {};
  if (instance.discountType != null)
    json['discountType'] = instance.discountType;
  if (instance.rate != null) json['rate'] = instance.rate;
  if (instance.id != null) json['_id'] = instance.id;

  return json;
}
