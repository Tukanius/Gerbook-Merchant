import 'package:merchant_gerbook_flutter/models/cancel_policy_detail.dart';
import 'package:merchant_gerbook_flutter/models/images.dart';
import 'package:merchant_gerbook_flutter/models/place_offers.dart';
import 'package:merchant_gerbook_flutter/models/properties.dart';
import 'package:merchant_gerbook_flutter/models/tags.dart';
import 'package:merchant_gerbook_flutter/models/travel_offers_detail.dart';

part '../parts/camp_data_edit.dart';

class CampDataEdit {
  String? id;
  String? code;
  String? name;
  String? description;
  List<Images>? images;
  Images? mainImage;
  String? additionalInformation;
  String? addressString;
  String? addressStringEng;
  num? longitude;
  num? latitude;

  String? checkInTime;
  String? checkOutTime;
  String? status;
  bool? isAdminActive;
  bool? isActive;
  String? link;
  bool? isOpenYearRound;
  bool? isClosed;

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
  List<Properties>? properties;

  List<PlaceOffers>? placeOffers;
  List<Tags>? tags;
  List<CancelPolicyDetail>? cancelPolicies;
  List<TravelOffersDetail>? travelOffers;

  // List<Discounts>? discounts;
  // CampRequest? campRequest;
  // Zone? zone;
  // List<String>? rawTravelOffers;

  CampDataEdit({
    this.id,
    this.code,
    this.name,
    this.description,
    this.images,
    this.mainImage,
    this.additionalInformation,
    this.addressString,
    this.addressStringEng,
    this.longitude,
    this.latitude,
    this.checkInTime,
    this.checkOutTime,
    this.status,
    this.isAdminActive,
    this.isActive,
    this.link,
    this.isOpenYearRound,
    this.isClosed,
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
    this.properties,

    //
    this.placeOffers,
    this.tags,
    this.cancelPolicies,
    this.travelOffers,
    //
  });
  factory CampDataEdit.fromJson(Map<String, dynamic> json) =>
      _$CampDataEditFromJson(json);
  Map<String, dynamic> toJson() => _$CampDataEditToJson(this);
}
