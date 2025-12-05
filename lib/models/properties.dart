import 'package:merchant_gerbook_flutter/models/blocked_dates.dart';
import 'package:merchant_gerbook_flutter/models/images.dart';
import 'package:merchant_gerbook_flutter/models/special_dates.dart';

part '../parts/properties.dart';

class Properties {
  String? id;
  // Merchant? merchant;
  bool? isGerBook;
  bool? isKhonog;
  String? name;
  String? description;
  List<Images>? images;
  Images? mainImage;
  String? additionalInformation;
  String? addressString;
  num? longitude;
  num? latitude;
  // Location? location;
  num? bedRoomsCount;
  num? bathRoomsCount;
  num? bedsCount;
  num? price;
  num? originalPrice;
  // num? discountedPrice;
  num? maxPersonCount;
  // List<PlaceOffers>? placeOffers;
  // List<Discount>? discounts;
  // List<CancelPolicies>? cancelPolicies;
  String? checkInTime;
  String? checkOutTime;
  bool? isPetAllowed;
  bool? isSmokingAllowed;
  String? quiteStartTime;
  String? quiteTimeEnd;
  String? status;
  String? deletedAt;
  // List<BlockedDate>? blockedDates;
  // List<SpecialDates>? specialDates;
  String? propertyVersion;
  String? createdAt;
  String? updatedAt;
  bool? isSaved;
  // List<Calendars>? calendars;
  // Bookings? booking;
  num? totalRates;
  num? avgRate;
  bool? hasReviewed;
  num? quantity;
  String? link;
  // List<MapProperty>? similiarProperties;
  bool? isSponsored;
  // List<Tags>? tags;
  // List<ShowPlace>? showPlaces;
  num? collateral;
  String? highlight;
  bool? isClosed;
  bool? isOpenYearRound;
  bool? isActive;
  bool? isAdminActive;

  List<BlockedDates>? blockedDates;
  List<SpecialDates>? specialDates;

  Properties({
    this.id,
    // this.merchant,
    this.isGerBook,
    this.isKhonog,
    this.name,
    this.description,
    this.images,
    this.mainImage,
    this.additionalInformation,
    this.addressString,
    this.longitude,
    this.latitude,
    // this.location,
    this.bedRoomsCount,
    this.bathRoomsCount,
    this.bedsCount,
    this.price,
    this.maxPersonCount,
    this.originalPrice,
    // this.placeOffers,
    // this.discounts,
    // this.cancelPolicies,
    this.checkInTime,
    this.checkOutTime,
    this.isPetAllowed,
    this.isSmokingAllowed,
    this.quiteStartTime,
    this.quiteTimeEnd,
    this.status,
    this.deletedAt,
    // this.blockedDates,
    // this.specialDates,
    this.propertyVersion,
    this.createdAt,
    this.updatedAt,
    this.isSaved,
    // this.calendars,
    // this.booking,
    this.avgRate,
    this.totalRates,
    this.hasReviewed,
    this.quantity,
    this.link,
    // this.similiarProperties,
    this.isSponsored,
    // this.tags,
    // this.showPlaces,
    this.collateral,
    this.highlight,
    this.isClosed,
    this.isOpenYearRound,
    this.isActive,
    this.isAdminActive,
    this.blockedDates,
    this.specialDates,
    // this.discountedPrice,
  });
  static $fromJson(Map<String, dynamic> json) => _$PropertiesFromJson(json);

  factory Properties.fromJson(Map<String, dynamic> json) =>
      _$PropertiesFromJson(json);
  Map<String, dynamic> toJson() => _$PropertiesToJson(this);
}
