import 'package:merchant_gerbook_flutter/models/cancel_policy_data.dart';

part '../parts/cancel_policy_detail.dart';

class CancelPolicyDetail {
  String? id;
  num? rate;
  CancelPolicyData? cancelPolicy;

  CancelPolicyDetail({this.id, this.rate, this.cancelPolicy});
  factory CancelPolicyDetail.fromJson(Map<String, dynamic> json) =>
      _$CancelPolicyDetailFromJson(json);
  Map<String, dynamic> toJson() => _$CancelPolicyDetailToJson(this);
}
