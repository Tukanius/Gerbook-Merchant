part '../parts/travel_offers.dart';

class TravelOffers {
  String? id;
  String? name;
  num? price;
  num? count;

  TravelOffers({this.id, this.name, this.price, this.count});
  static $fromJson(Map<String, dynamic> json) => _$TravelOffersFromJson(json);

  factory TravelOffers.fromJson(Map<String, dynamic> json) =>
      _$TravelOffersFromJson(json);
  Map<String, dynamic> toJson() => _$TravelOffersToJson(this);
}
