part of '../models/cancel_policy_detail.dart';

CancelPolicyDetail _$CancelPolicyDetailFromJson(Map<String, dynamic> json) {
  return CancelPolicyDetail(
    id: json['_id'] != null ? json['_id'] as String : null,
    rate: json['rate'] != null ? json['rate'] as num : null,
    cancelPolicy: json['cancelPolicy'] != null
        ? CancelPolicyData.fromJson(json['cancelPolicy'])
        : null,
  );
}

Map<String, dynamic> _$CancelPolicyDetailToJson(CancelPolicyDetail instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.rate != null) json['rate'] = instance.rate;
  if (instance.cancelPolicy != null)
    json['cancelPolicy'] = instance.cancelPolicy;

  return json;
}
