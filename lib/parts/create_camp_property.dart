part of '../models/create_camp_property.dart';

CreateCampProperty _$CreateCampPropertyFromJson(Map<String, dynamic> json) {
  return CreateCampProperty(
    id: json['_id'] != null ? json['_id'] as String : null,
    // merchant:
    //     json['merchant'] != null ? Merchant.fromJson(json['merchant']) : null,
    isGerBook: json['isGerBook'] != null ? json['isGerBook'] as bool : null,
    isKhonog: json['isKhonog'] != null ? json['isKhonog'] as bool : null,
    name: json['name'] != null ? json['name'] as String : null,
    description: json['description'] != null
        ? json['description'] as String
        : null,
    images: json['images'] != null
        ? (json['images'] as List).map((e) => e as String).toList()
        : null,
    // mainImage: json['mainImage'] != null
    //     ? Images.fromJson(json['mainImage'])
    //     : null,
    mainImage: json['mainImage'] != null ? json['mainImage'] as String : null,

    additionalInformation: json['additionalInformation'] != null
        ? json['additionalInformation'] as String
        : null,
    addressString: json['addressString'] != null
        ? json['addressString'] as String
        : null,
    longitude: json['longitude'] != null ? json['longitude'] as num : null,
    latitude: json['latitude'] != null ? json['latitude'] as num : null,
    // location:
    //     json['location'] != null ? Location.fromJson(json['location']) : null,
    bedRoomsCount: json['bedRoomsCount'] != null
        ? json['bedRoomsCount'] as num
        : null,
    bathRoomsCount: json['bathRoomsCount'] != null
        ? json['bathRoomsCount'] as num
        : null,
    bedsCount: json['bedsCount'] != null ? json['bedsCount'] as num : null,
    price: json['price'] != null ? json['price'] as num : null,
    originalPrice: json['originalPrice'] != null
        ? json['originalPrice'] as num
        : null,
    maxPersonCount: json['maxPersonCount'] != null
        ? json['maxPersonCount'] as num
        : null,
    // placeOffers: json['placeOffers'] != null
    //     ? (json['placeOffers'] as List)
    //         .map((e) => PlaceOffers.fromJson(e))
    //         .toList()
    //     : null,
    // discounts: json['discounts'] != null
    //     ? (json['discounts'] as List).map((e) => Discount.fromJson(e)).toList()
    //     : null,
    // cancelPolicies: json['cancelPolicies'] != null
    //     ? (json['cancelPolicies'] as List)
    //         .map((e) => CancelPolicies.fromJson(e))
    //         .toList()
    //     : null,
    checkInTime: json['checkInTime'] != null
        ? json['checkInTime'] as String
        : null,
    checkOutTime: json['checkOutTime'] != null
        ? json['checkOutTime'] as String
        : null,
    isPetAllowed: json['isPetAllowed'] != null
        ? json['isPetAllowed'] as bool
        : null,
    isSmokingAllowed: json['isSmokingAllowed'] != null
        ? json['isSmokingAllowed'] as bool
        : null,
    quiteStartTime: json['quiteStartTime'] != null
        ? json['quiteStartTime'] as String
        : null,
    quiteTimeEnd: json['quiteTimeEnd'] != null
        ? json['quiteTimeEnd'] as String
        : null,
    status: json['status'] != null ? json['status'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    // blockedDates: json['blockedDates'] != null
    //     ? (json['blockedDates'] as List)
    //         .map((e) => BlockedDate.fromJson(e))
    //         .toList()
    //     : null,
    // blockedDates: json['blockedDates'] != null
    //     ? (json['blockedDates'] as List).map((e) => e as String).toList()
    //     : null,
    // specialDates: json['specialDates'] != null
    //     ? (json['specialDates'] as List)
    //         .map((e) => SpecialDates.fromJson(e))
    //         .toList()
    //     : null,
    propertyVersion: json['propertyVersion'] != null
        ? json['propertyVersion'] as String
        : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    isSaved: json['isSaved'] != null ? json['isSaved'] as bool : null,
    // calendars: json['calendars'] != null
    //     ? (json['calendars'] as List).map((e) => Calendars.fromJson(e)).toList()
    //     : null,
    // booking:
    //     json['booking'] != null ? Bookings.fromJson(json['booking']) : null,
    avgRate: json['avgRate'] != null ? json['avgRate'] as num : null,
    totalRates: json['totalRates'] != null ? json['totalRates'] as num : null,
    hasReviewed: json['hasReviewed'] != null
        ? json['hasReviewed'] as bool
        : null,
    quantity: json['quantity'] != null ? json['quantity'] as num : null,
    link: json['link'] != null ? json['link'] as String : null,
    // similiarCreateCampProperty: json['similiarCreateCampProperty'] != null
    //     ? (json['similiarCreateCampProperty'] as List)
    //         .map((e) => MapProperty.fromJson(e))
    //         .toList()
    //     : null,
    isSponsored: json['isSponsored'] != null
        ? json['isSponsored'] as bool
        : null,
    // tags: json['tags'] != null
    //     ? (json['tags'] as List).map((e) => Tags.fromJson(e)).toList()
    //     : null,
    // showPlaces: json['showPlaces'] != null
    //     ? (json['showPlaces'] as List)
    //         .map((e) => ShowPlace.fromJson(e))
    //         .toList()
    //     : null,
    collateral: json['collateral'] != null ? json['collateral'] as num : null,
    highlight: json['highlight'] != null ? json['highlight'] as String : null,
    isClosed: json['isClosed'] != null ? json['isClosed'] as bool : null,
    isOpenYearRound: json['isOpenYearRound'] != null
        ? json['isOpenYearRound'] as bool
        : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    isAdminActive: json['isAdminActive'] != null
        ? json['isAdminActive'] as bool
        : null,
  );
}

Map<String, dynamic> _$CreateCampPropertyToJson(CreateCampProperty instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.isGerBook != null) json['isGerBook'] = instance.isGerBook;
  if (instance.isKhonog != null) json['isKhonog'] = instance.isKhonog;
  // if (instance.merchant != null) json['merchant'] = instance.merchant;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.additionalInformation != null)
    json['additionalInformation'] = instance.additionalInformation;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.images != null) json['images'] = instance.images;
  if (instance.mainImage != null) json['mainImage'] = instance.mainImage;
  if (instance.addressString != null)
    json['addressString'] = instance.addressString;
  if (instance.longitude != null) json['longitude'] = instance.longitude;
  if (instance.latitude != null) json['latitude'] = instance.latitude;
  // if (instance.location != null) json['location'] = instance.location;
  if (instance.bedRoomsCount != null)
    json['bedRoomsCount'] = instance.bedRoomsCount;
  if (instance.bathRoomsCount != null)
    json['bathRoomsCount'] = instance.bathRoomsCount;
  if (instance.bedsCount != null) json['bedsCount'] = instance.bedsCount;
  if (instance.price != null) json['price'] = instance.price;
  if (instance.originalPrice != null)
    json['originalPrice'] = instance.originalPrice;
  if (instance.maxPersonCount != null)
    json['maxPersonCount'] = instance.maxPersonCount;
  // if (instance.placeOffers != null) json['placeOffers'] = instance.placeOffers;
  // if (instance.discounts != null) json['discounts'] = instance.discounts;
  // if (instance.cancelPolicies != null)
  //   json['cancelPolicies'] = instance.cancelPolicies;
  if (instance.checkInTime != null) json['checkInTime'] = instance.checkInTime;
  if (instance.checkOutTime != null)
    json['checkOutTime'] = instance.checkOutTime;
  if (instance.isPetAllowed != null)
    json['isPetAllowed'] = instance.isPetAllowed;
  if (instance.isSmokingAllowed != null)
    json['isSmokingAllowed'] = instance.isSmokingAllowed;
  if (instance.quiteStartTime != null)
    json['quiteStartTime'] = instance.quiteStartTime;
  if (instance.quiteTimeEnd != null)
    json['quiteTimeEnd'] = instance.quiteTimeEnd;
  if (instance.status != null) json['status'] = instance.status;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  // if (instance.blockedDates != null)
  //   json['blockedDates'] = instance.blockedDates;
  // if (instance.specialDates != null)
  //   json['specialDates'] = instance.specialDates;
  if (instance.propertyVersion != null)
    json['propertyVersion'] = instance.propertyVersion;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.isSaved != null) json['isSaved'] = instance.isSaved;
  // if (instance.calendars != null) json['calendars'] = instance.calendars;
  // if (instance.booking != null) json['booking'] = instance.booking;
  if (instance.totalRates != null) json['totalRates'] = instance.totalRates;
  if (instance.avgRate != null) json['avgRate'] = instance.avgRate;
  if (instance.hasReviewed != null) json['hasReviewed'] = instance.hasReviewed;
  if (instance.quantity != null) json['quantity'] = instance.quantity;
  if (instance.link != null) json['link'] = instance.link;
  // if (instance.similiarCreateCampProperty != null)
  //   json['similiarCreateCampProperty'] = instance.similiarCreateCampProperty;
  if (instance.isSponsored != null) json['isSponsored'] = instance.isSponsored;
  // if (instance.tags != null) json['tags'] = instance.tags;
  // if (instance.showPlaces != null) json['showPlaces'] = instance.showPlaces;
  if (instance.collateral != null) json['collateral'] = instance.collateral;
  if (instance.highlight != null) json['highlight'] = instance.highlight;
  if (instance.isClosed != null) json['isClosed'] = instance.isClosed;
  if (instance.isOpenYearRound != null)
    json['isOpenYearRound'] = instance.isOpenYearRound;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.isAdminActive != null)
    json['isAdminActive'] = instance.isAdminActive;

  return json;
}
