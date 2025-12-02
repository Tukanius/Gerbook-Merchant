import 'package:merchant_gerbook_flutter/models/properties.dart';

part '../parts/booking_item.dart';

class BookingItem {
  Properties? property;
  num? personCount;
  num? quantity;
  // BookingItem? property;

  BookingItem({this.property, this.personCount, this.quantity});
  static $fromJson(Map<String, dynamic> json) => _$BookingItemFromJson(json);

  factory BookingItem.fromJson(Map<String, dynamic> json) =>
      _$BookingItemFromJson(json);
  Map<String, dynamic> toJson() => _$BookingItemToJson(this);
}
