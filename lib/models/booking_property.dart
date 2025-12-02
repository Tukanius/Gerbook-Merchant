part '../parts/booking_property.dart';

class BookingProperty {
  String? id;
  String? name;
  String? addressString;
  // BookingProperty? property;

  BookingProperty({this.id, this.name, this.addressString});
  static $fromJson(Map<String, dynamic> json) =>
      _$BookingPropertyFromJson(json);

  factory BookingProperty.fromJson(Map<String, dynamic> json) =>
      _$BookingPropertyFromJson(json);
  Map<String, dynamic> toJson() => _$BookingPropertyToJson(this);
}
