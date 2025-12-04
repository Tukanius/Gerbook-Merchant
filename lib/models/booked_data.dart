import 'package:merchant_gerbook_flutter/models/booking_item.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';

part '../parts/booked_data.dart';

class BookedData {
  String? id;
  // Properties? property;
  List<BookingItem>? properties;
  User? user;
  String? code;
  num? personCount;
  num? days;
  num? amount;
  num? totalAmount;
  num? discount;
  String? status;
  String? statusDate;
  String? startDate;
  String? endDate;
  String? deadline;
  num? propertyQuantity;
  String? search;
  num? refundFee;
  num? travelOffersAmount;
  String? createdAt;
  String? updatedAt;
  // Payment? payment;

  BookedData({
    this.id,
    this.properties,
    this.user,
    this.code,
    this.personCount,
    this.days,
    this.amount,
    this.totalAmount,
    this.discount,
    this.status,
    this.statusDate,
    this.startDate,
    this.endDate,
    this.deadline,
    this.propertyQuantity,
    this.search,
    this.refundFee,
    this.travelOffersAmount,
    this.createdAt,
    this.updatedAt,
    // this.payment,
  });
  factory BookedData.fromJson(Map<String, dynamic> json) =>
      _$BookedDataFromJson(json);
  Map<String, dynamic> toJson() => _$BookedDataToJson(this);
}
