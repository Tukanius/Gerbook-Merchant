import 'package:merchant_gerbook_flutter/models/booking_item.dart';

part '../parts/booking_list.dart';

class BookingList {
  String? id;
  List<BookingItem>? properties;
  // User? user;
  String? code;
  // int? personCount;
  num? days;
  // int? amount;
  num? totalAmount;
  // int? discount;
  String? status;
  // String? statusDate;
  String? startDate;
  String? endDate;
  // String? merchant;
  // String? deadline;
  // int? propertyQuantity;
  // String? search;
  // int? refundFee;
  // String? createdServer;
  // int? travelOffersAmount;
  // List<String>? travelOffers;
  String? createdAt;
  // String? updatedAt;
  // Payment? payment;

  BookingList({
    this.id,
    this.properties,
    // this.user,
    this.code,
    // this.personCount,
    this.days,
    // this.amount,
    this.totalAmount,
    // this.discount,
    this.status,
    // this.statusDate,
    this.startDate,
    this.endDate,
    // this.merchant,
    // this.deadline,
    // this.propertyQuantity,
    // this.search,
    // this.refundFee,
    // this.createdServer,
    // this.travelOffersAmount,
    // // this.travelOffers,
    this.createdAt,
    // this.updatedAt,
    // this.payment,
  });
  factory BookingList.fromJson(Map<String, dynamic> json) =>
      _$BookingListFromJson(json);
  Map<String, dynamic> toJson() => _$BookingListToJson(this);
}
