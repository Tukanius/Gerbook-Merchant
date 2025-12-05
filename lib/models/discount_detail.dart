import 'package:merchant_gerbook_flutter/models/discount_item.dart';

part '../parts/discount_detail.dart';

class DiscountDetail {
  DiscountItem? discountType;
  int? rate;
  String? id;

  DiscountDetail({this.discountType, this.rate, this.id});
  factory DiscountDetail.fromJson(Map<String, dynamic> json) =>
      _$DiscountDetailFromJson(json);
  Map<String, dynamic> toJson() => _$DiscountDetailToJson(this);
}
