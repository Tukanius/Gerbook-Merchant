part '../parts/travel_offers_data.dart';

class TravelOffersData {
  String? id;
  String? name;
  int? sort;

  TravelOffersData({this.id, this.name, this.sort});
  static $fromJson(Map<String, dynamic> json) =>
      _$TravelOffersDataFromJson(json);

  factory TravelOffersData.fromJson(Map<String, dynamic> json) =>
      _$TravelOffersDataFromJson(json);
  Map<String, dynamic> toJson() => _$TravelOffersDataToJson(this);
}
