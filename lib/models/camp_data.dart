import 'package:merchant_gerbook_flutter/models/images.dart';
import 'package:merchant_gerbook_flutter/models/properties.dart';

part '../parts/camp_data.dart';

class CampData {
  String? id;
  String? code;
  // Merchant? merchant;
  String? name;
  String? description;
  List<Images>? images;
  Images? mainImage;
  // Level0? level0;
  // Level1? level1;
  // Null? level2;
  // Null? level3;
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
  // List<Tags>? tags;
  bool? isAdminActive;
  bool? isActive;
  String? link;
  bool? isOpenYearRound;
  bool? isClosed;
  // Zone? zone;
  // List<TravelOffers>? travelOffers;
  // List<String>? rawTravelOffers;
  num? price;
  bool? isDiscounted;
  bool? isSponsored;
  num? avgRate;
  num? totalRates;
  num? savesCount;
  num? capacity;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  // CampRequest? campRequest;
  List<Properties>? properties;

  CampData({
    this.id,
    this.code,
    // this.merchant,
    this.name,
    this.description,
    this.images,
    this.mainImage,
    // this.level0,
    // this.level1,
    // this.level2,
    // this.level3,
    this.additionalInformation,
    this.addressString,
    this.addressStringEng,
    this.longitude,
    this.latitude,
    // this.location,
    // this.placeOffers,
    // this.discounts,
    // this.cancelPolicies,
    this.checkInTime,
    this.checkOutTime,
    this.status,
    // this.tags,
    this.isAdminActive,
    this.isActive,
    this.link,
    this.isOpenYearRound,
    this.isClosed,
    // this.zone,
    // this.travelOffers,
    // this.rawTravelOffers,
    this.price,
    this.isDiscounted,
    this.isSponsored,
    this.avgRate,
    this.totalRates,
    this.savesCount,
    this.capacity,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    // this.campRequest,
    this.properties,
  });
  factory CampData.fromJson(Map<String, dynamic> json) =>
      _$CampDataFromJson(json);
  Map<String, dynamic> toJson() => _$CampDataToJson(this);
}
