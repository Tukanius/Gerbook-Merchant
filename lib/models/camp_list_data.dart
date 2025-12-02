import 'package:merchant_gerbook_flutter/models/images.dart';

part '../parts/camp_list_data.dart';

class CampListData {
  String? id;
  String? code;
  String? merchant;
  String? name;
  String? description;
  num? price;
  // List<Images>? images;
  Images? mainImage;
  // Level0? level0;
  // Level1? level1;
  // Level1? level2;
  // Level3? level3;
  String? additionalInformation;
  String? addressString;
  String? addressStringEng;
  num? longitude;
  num? latitude;
  // Location? location;
  // List<PlaceOffers>? placeOffers;
  // List<Discounts>? discounts;
  // List<CancelPolicies>? cancelPolicies;
  String? checkInTime;
  String? checkOutTime;
  String? status;
  // List<String>? tags;
  bool? isAdminActive;
  bool? isActive;
  String? link;
  bool? isOpenYearRound;
  bool? isClosed;
  // Zone? zone;
  // List<TravelOffers>? travelOffers;
  // List<String>? rawTravelOffers;
  String? createdAt;
  String? updatedAt;
  num? capacity;

  CampListData({
    this.id,
    this.code,
    this.merchant,
    this.name,
    this.description,
    this.mainImage,
    this.additionalInformation,
    this.addressString,
    this.addressStringEng,
    this.longitude,
    this.latitude,
    this.checkInTime,
    this.checkOutTime,
    this.status,
    // this.tags,
    this.isAdminActive,
    this.isActive,
    this.link,
    this.isOpenYearRound,
    this.isClosed,
    // this.rawTravelOffers,
    this.createdAt,
    this.updatedAt,
    this.price,
    this.capacity,
  });
  factory CampListData.fromJson(Map<String, dynamic> json) =>
      _$CampListDataFromJson(json);
  Map<String, dynamic> toJson() => _$CampListDataToJson(this);
}
