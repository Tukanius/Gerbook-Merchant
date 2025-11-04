import 'package:merchant_gerbook_flutter/models/images.dart';

part '../parts/place_offers.dart';

class PlaceOffers {
  String? id;
  String? name;
  String? type;
  String? appType;
  Images? image;
  num? sort;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  PlaceOffers({
    this.id,
    this.name,
    this.appType,
    this.image,
    this.sort,
    this.type,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });
  static $fromJson(Map<String, dynamic> json) => _$PlaceOffersFromJson(json);

  factory PlaceOffers.fromJson(Map<String, dynamic> json) =>
      _$PlaceOffersFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceOffersToJson(this);
}
