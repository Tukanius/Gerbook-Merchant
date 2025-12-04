part of '../models/booked_data.dart';

BookedData _$BookedDataFromJson(Map<String, dynamic> json) {
  return BookedData(
    id: json['_id'] != null ? json['_id'] as String : null,
    // property: json['property'] != null
    //     ? Properties.fromJson(json['property'])
    //     : null,
    properties: json['properties'] != null
        ? (json['properties'] as List)
              .map((e) => BookingItem.fromJson(e))
              .toList()
        : null,
    user: json['user'] != null ? User.fromJson(json['user']) : null,

    code: json['code'] != null ? json['code'] as String : null,
    personCount: json['personCount'] != null
        ? json['personCount'] as num
        : null,
    days: json['days'] != null ? json['days'] as num : null,
    amount: json['amount'] != null ? json['amount'] as num : null,
    totalAmount: json['totalAmount'] != null
        ? json['totalAmount'] as num
        : null,
    discount: json['discount'] != null ? json['discount'] as num : null,
    status: json['status'] != null ? json['status'] as String : null,
    statusDate: json['statusDate'] != null
        ? json['statusDate'] as String
        : null,
    startDate: json['startDate'] != null ? json['startDate'] as String : null,
    endDate: json['endDate'] != null ? json['endDate'] as String : null,
    deadline: json['deadline'] != null ? json['deadline'] as String : null,
    propertyQuantity: json['propertyQuantity'] != null
        ? json['propertyQuantity'] as num
        : null,
    search: json['search'] != null ? json['search'] as String : null,
    refundFee: json['refundFee'] != null ? json['refundFee'] as num : null,
    travelOffersAmount: json['travelOffersAmount'] != null
        ? json['travelOffersAmount'] as num
        : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$BookedDataToJson(BookedData instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.properties != null) json['properties'] = instance.properties;
  if (instance.user != null) json['user'] = instance.user;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.personCount != null) json['personCount'] = instance.personCount;
  if (instance.days != null) json['days'] = instance.days;
  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.totalAmount != null) json['totalAmount'] = instance.totalAmount;
  if (instance.discount != null) json['discount'] = instance.discount;
  if (instance.status != null) json['status'] = instance.status;
  if (instance.statusDate != null) json['statusDate'] = instance.statusDate;
  if (instance.startDate != null) json['startDate'] = instance.startDate;
  if (instance.endDate != null) json['endDate'] = instance.endDate;
  if (instance.deadline != null) json['deadline'] = instance.deadline;
  if (instance.propertyQuantity != null)
    json['propertyQuantity'] = instance.propertyQuantity;
  if (instance.search != null) json['search'] = instance.search;
  if (instance.refundFee != null) json['refundFee'] = instance.refundFee;
  if (instance.travelOffersAmount != null)
    json['travelOffersAmount'] = instance.travelOffersAmount;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
