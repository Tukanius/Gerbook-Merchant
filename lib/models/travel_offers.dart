part '../parts/travel_offers.dart';

class TravelOffers {
  String? id;
  String? name;

  TravelOffers({this.id, this.name});
  static $fromJson(Map<String, dynamic> json) => _$TravelOffersFromJson(json);

  factory TravelOffers.fromJson(Map<String, dynamic> json) =>
      _$TravelOffersFromJson(json);
  Map<String, dynamic> toJson() => _$TravelOffersToJson(this);
}
