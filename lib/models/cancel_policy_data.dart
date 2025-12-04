part '../parts/cancel_policy_data.dart';

class CancelPolicyData {
  String? id;
  String? name;
  String? nameEng;
  int? start;
  String? startType;
  int? end;
  String? endType;
  List<int>? variants;
  int? defaultVariant;

  CancelPolicyData({
    this.id,
    this.name,
    this.nameEng,
    this.start,
    this.startType,
    this.end,
    this.endType,
    this.variants,
    this.defaultVariant,
  });
  factory CancelPolicyData.fromJson(Map<String, dynamic> json) =>
      _$CancelPolicyDataFromJson(json);
  Map<String, dynamic> toJson() => _$CancelPolicyDataToJson(this);
}
