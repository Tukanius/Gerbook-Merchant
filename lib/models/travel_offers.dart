part '../parts/travel_offers.dart';

class TravelOffers {
  String? id;
  String? name;
  num? price;
  num? maxQuantity;
  String? travelOffer;

  TravelOffers({
    this.id,
    this.name,
    this.price,
    this.maxQuantity,
    this.travelOffer,
  });
  static $fromJson(Map<String, dynamic> json) => _$TravelOffersFromJson(json);

  factory TravelOffers.fromJson(Map<String, dynamic> json) =>
      _$TravelOffersFromJson(json);
  Map<String, dynamic> toJson() => _$TravelOffersToJson(this);
}
