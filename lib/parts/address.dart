part of '../models/address.dart';

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    id: json['_id'] != null ? json['_id'] as String : null,
    // name: json['name'] != null ? json['name'] as String : null,
    nameEng: json['nameEng'] != null ? json['nameEng'] as String : null,
    level: json['level'] != null ? json['level'] as int : null,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  // if (instance.name != null) json['name'] = instance.name;
  if (instance.nameEng != null) json['nameEng'] = instance.nameEng;
  if (instance.level != null) json['level'] = instance.level;

  return json;
}
