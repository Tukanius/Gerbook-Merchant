part of '../models/cancel_policy.dart';

CancelPolicy _$CancelPolicyFromJson(Map<String, dynamic> json) {
  return CancelPolicy(
    id: json['_id'] != null ? json['_id'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    nameEng: json['nameEng'] != null ? json['nameEng'] as String : null,
    start: json['start'] != null ? json['start'] as int : null,
    variants: json['variants'] != null
        ? (json['variants'] as List).map((e) => e as int).toList()
        : null,
    defaultVariant: json['defaultVariant'] != null
        ? json['defaultVariant'] as int
        : null,
    procent: json['procent'] != null ? json['procent'] as num : null,
  );
}

Map<String, dynamic> _$CancelPolicyToJson(CancelPolicy instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.nameEng != null) json['nameEng'] = instance.nameEng;
  if (instance.start != null) json['start'] = instance.start;
  if (instance.variants != null) json['variants'] = instance.variants;
  if (instance.defaultVariant != null)
    json['defaultVariant'] = instance.defaultVariant;
  if (instance.procent != null) json['procent'] = instance.procent;

  return json;
}
