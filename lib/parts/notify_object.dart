part of '../models/notify_object.dart';

NotifyObject _$NotifyObjectFromJson(Map<String, dynamic> json) {
  return NotifyObject(
    id: json['_id'] != null ? json['_id'] as String : null,
    property: json['property'] != null ? json['property'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
    days: json['days'] != null ? json['days'] as num : null,
    amount: json['amount'] != null ? json['amount'] as num : null,
    totalAmoung:
        json['totalAmoung'] != null ? json['totalAmoung'] as num : null,
    discount: json['discount'] != null ? json['discount'] as num : null,
    status: json['status'] != null ? json['status'] as String : null,
    statusDate:
        json['statusDate'] != null ? json['statusDate'] as String : null,
    startDate: json['startDate'] != null ? json['startDate'] as String : null,
    endDate: json['endDate'] != null ? json['endDate'] as String : null,
    merchant: json['merchant'] != null ? json['merchant'] as String : null,
    deadline: json['deadline'] != null ? json['deadline'] as String : null,
    propertyQuantity: json['propertyQuantity'] != null
        ? json['propertyQuantity'] as num
        : null,
    search: json['search'] != null ? json['search'] as String : null,
    payment: json['payment'] != null ? json['payment'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$NotifyObjectToJson(NotifyObject instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.property != null) json['property'] = instance.property;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.days != null) json['days'] = instance.days;
  if (instance.amount != null) json['amount'] = instance.amount;
  if (instance.totalAmoung != null) json['totalAmoung'] = instance.totalAmoung;
  if (instance.discount != null) json['discount'] = instance.discount;
  if (instance.status != null) json['status'] = instance.status;
  if (instance.statusDate != null) json['statusDate'] = instance.statusDate;
  if (instance.startDate != null) json['startDate'] = instance.startDate;
  if (instance.endDate != null) json['endDate'] = instance.endDate;
  if (instance.merchant != null) json['merchant'] = instance.merchant;
  if (instance.deadline != null) json['deadline'] = instance.deadline;
  if (instance.propertyQuantity != null)
    json['propertyQuantity'] = instance.propertyQuantity;
  if (instance.search != null) json['search'] = instance.search;
  if (instance.payment != null) json['payment'] = instance.payment;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
