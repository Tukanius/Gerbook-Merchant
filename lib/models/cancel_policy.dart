part '../parts/cancel_policy.dart';

class CancelPolicy {
  String? id;
  String? name;
  String? nameEng;
  int? start;
  String? startType;
  List<int>? variants;
  int? defaultVariant;
  num? rate;
  String? cancelPolicy;

  CancelPolicy({
    this.id,
    this.name,
    this.nameEng,
    this.start,
    this.startType,
    this.variants,
    this.defaultVariant,
    this.rate,
    this.cancelPolicy,
  });
  factory CancelPolicy.fromJson(Map<String, dynamic> json) =>
      _$CancelPolicyFromJson(json);
  Map<String, dynamic> toJson() => _$CancelPolicyToJson(this);
}
