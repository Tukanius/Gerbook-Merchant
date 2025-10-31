part '../parts/notify_object.dart';

class NotifyObject {
  String? id;
  String? property;
  String? code;
  num? days;
  num? amount;
  num? totalAmoung;
  num? discount;
  String? status;
  String? statusDate;
  String? startDate;
  String? endDate;
  String? merchant;
  String? deadline;
  num? propertyQuantity;
  String? search;
  String? payment;
  String? createdAt;
  String? updatedAt;

  NotifyObject({
    this.id,
    this.property,
    this.code,
    this.days,
    this.amount,
    this.totalAmoung,
    this.discount,
    this.status,
    this.statusDate,
    this.startDate,
    this.endDate,
    this.merchant,
    this.deadline,
    this.propertyQuantity,
    this.search,
    this.payment,
    this.createdAt,
    this.updatedAt,
  });
  factory NotifyObject.fromJson(Map<String, dynamic> json) =>
      _$NotifyObjectFromJson(json);
  Map<String, dynamic> toJson() => _$NotifyObjectToJson(this);
}
