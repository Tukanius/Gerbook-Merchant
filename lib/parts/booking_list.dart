part of '../models/booking_list.dart';

BookingList _$BookingListFromJson(Map<String, dynamic> json) {
  return BookingList(
    id: json['_id'] != null ? json['_id'] as String : null,
    // property: json['property'] != null
    //     ? BookingProperty.fromJson(json['property'])
    //     : null,
    properties: json['properties'] != null
        ? (json['properties'] as List)
              .map((e) => BookingItem.fromJson(e))
              .toList()
        : null,
    // user: json['user'] != null ? User.fromJson(json['user']) : null,
    code: json['code'] != null ? json['code'] as String : null,
    // personCount: json['personCount'] != null
    //     ? json['personCount'] as int
    //     : null,
    days: json['days'] != null ? json['days'] as num : null,
    // amount: json['amount'] != null ? json['amount'] as int : null,
    totalAmount: json['totalAmount'] != null
        ? json['totalAmount'] as num
        : null,
    // discount: json['discount'] != null ? json['discount'] as int : null,
    status: json['status'] != null ? json['status'] as String : null,
    // statusDate: json['statusDate'] != null
    //     ? json['statusDate'] as String
    //     : null,
    startDate: json['startDate'] != null ? json['startDate'] as String : null,
    endDate: json['endDate'] != null ? json['endDate'] as String : null,
    // merchant: json['merchant'] != null ? json['merchant'] as String : null,
    // deadline: json['deadline'] != null ? json['deadline'] as String : null,
    // propertyQuantity: json['propertyQuantity'] != null
    //     ? json['propertyQuantity'] as int
    //     : null,
    // search: json['search'] != null ? json['search'] as String : null,
    // refundFee: json['refundFee'] != null ? json['refundFee'] as int : null,
    // createdServer: json['createdServer'] != null
    //     ? json['createdServer'] as String
    //     : null,
    // travelOffersAmount: json['travelOffersAmount'] != null
    //     ? json['travelOffersAmount'] as int
    //     : null,
    // // travelOffers: json['travelOffers'] != null
    // //     ? (json['travelOffers'] as List).map((e) => e as String).toList()
    // //     : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    // updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    // payment: json['payment'] != null ? Payment.fromJson(json['payment']) : null,
  );
}

Map<String, dynamic> _$BookingListToJson(BookingList instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.properties != null) json['properties'] = instance.properties;
  // if (instance.user != null) json['user'] = instance.user;
  if (instance.code != null) json['code'] = instance.code;
  // if (instance.personCount != null) json['personCount'] = instance.personCount;
  if (instance.days != null) json['days'] = instance.days;
  // if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;
  // if (instance.discount != null) json['discount'] = instance.discount;
  if (instance.status != null) json['status'] = instance.status;
  // if (instance.statusDate != null) json['statusDate'] = instance.statusDate;
  if (instance.startDate != null) json['startDate'] = instance.startDate;
  if (instance.endDate != null) json['endDate'] = instance.endDate;
  // if (instance.merchant != null) json['merchant'] = instance.merchant;
  // if (instance.deadline != null) json['deadline'] = instance.deadline;
  // if (instance.propertyQuantity != null)
  //   json['propertyQuantity'] = instance.propertyQuantity;
  // if (instance.search != null) json['search'] = instance.search;
  // if (instance.refundFee != null) json['refundFee'] = instance.refundFee;
  // if (instance.createdServer != null)
  //   json['createdServer'] = instance.createdServer;
  // if (instance.travelOffersAmount != null)
  //   json['travelOffersAmount'] = instance.travelOffersAmount;
  // // if (instance.travelOffers != null)
  // //   json['travelOffers'] = instance.travelOffers;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  // if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  // if (instance.payment != null) json['payment'] = instance.payment;

  return json;
}
