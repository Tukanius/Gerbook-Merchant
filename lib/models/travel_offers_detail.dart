import 'package:merchant_gerbook_flutter/models/travel_offers_data.dart';

part '../parts/travel_offers_detail.dart';

class TravelOffersDetail {
  TravelOffersData? travelOffer;
  int? price;
  int? maxQuantity;
  String? id;

  TravelOffersDetail({this.travelOffer, this.price, this.maxQuantity, this.id});
  static $fromJson(Map<String, dynamic> json) =>
      _$TravelOffersDetailFromJson(json);

  factory TravelOffersDetail.fromJson(Map<String, dynamic> json) =>
      _$TravelOffersDetailFromJson(json);
  Map<String, dynamic> toJson() => _$TravelOffersDetailToJson(this);
}
