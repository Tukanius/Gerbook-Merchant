import 'package:merchant_gerbook_flutter/models/place_offers.dart';
import 'package:merchant_gerbook_flutter/models/tags.dart';

part '../parts/filter_model.dart';

class FilterModel {
  int? count;
  int? priceMin;
  int? priceMax;
  List<PlaceOffers>? placeOffers;
  List<Tags>? tags;

  FilterModel({
    this.count,
    this.priceMin,
    this.priceMax,
    this.placeOffers,
    this.tags,
  });
  static $fromJson(Map<String, dynamic> json) => _$FilterModelFromJson(json);

  factory FilterModel.fromJson(Map<String, dynamic> json) =>
      _$FilterModelFromJson(json);
  Map<String, dynamic> toJson() => _$FilterModelToJson(this);
}
