part of '../models/booking_property.dart';

BookingProperty _$BookingPropertyFromJson(Map<String, dynamic> json) {
  return BookingProperty(
    id: json['_id'] != null ? json['_id'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    addressString: json['addressString'] != null
        ? json['addressString'] as String
        : null,
    // property: json['property'] != null
    //     ? BookingProperty.fromJson(json['property'])
    //     : null,
  );
}

Map<String, dynamic> _$BookingPropertyToJson(BookingProperty instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;

  if (instance.addressString != null)
    json['addressString'] = instance.addressString;
  // if (instance.property != null) json['property'] = instance.property;

  return json;
}
