part of '../models/cancel_policy_data.dart';

CancelPolicyData _$CancelPolicyDataFromJson(Map<String, dynamic> json) {
  return CancelPolicyData(
    id: json['_id'] != null ? json['_id'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    nameEng: json['nameEng'] != null ? json['nameEng'] as String : null,
    start: json['start'] != null ? json['start'] as int : null,
    startType: json['startType'] != null ? json['startType'] as String : null,
    end: json['end'] != null ? json['end'] as int : null,
    endType: json['endType'] != null ? json['endType'] as String : null,
    variants: json['variants'] != null
        ? (json['variants'] as List).map((e) => e as int).toList()
        : null,
    defaultVariant: json['defaultVariant'] != null
        ? json['defaultVariant'] as int
        : null,
  );
}

Map<String, dynamic> _$CancelPolicyDataToJson(CancelPolicyData instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.nameEng != null) json['nameEng'] = instance.nameEng;
  if (instance.start != null) json['start'] = instance.start;
  if (instance.startType != null) json['startType'] = instance.startType;
  if (instance.end != null) json['end'] = instance.end;
  if (instance.endType != null) json['endType'] = instance.endType;
  if (instance.variants != null) json['variants'] = instance.variants;
  if (instance.defaultVariant != null)
    json['defaultVariant'] = instance.defaultVariant;

  return json;
}
