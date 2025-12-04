part of '../models/camp_data_edit.dart';

CampDataEdit _$CampDataEditFromJson(Map<String, dynamic> json) {
  return CampDataEdit(
    id: json['_id'] != null ? json['_id'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    description: json['description'] != null
        ? json['description'] as String
        : null,
    images: json['images'] != null
        ? (json['images'] as List).map((e) => Images.fromJson(e)).toList()
        : null,
    mainImage: json['mainImage'] != null
        ? Images.fromJson(json['mainImage'])
        : null,

    additionalInformation: json['additionalInformation'] != null
        ? json['additionalInformation'] as String
        : null,
    addressString: json['addressString'] != null
        ? json['addressString'] as String
        : null,
    addressStringEng: json['addressStringEng'] != null
        ? json['addressStringEng'] as String
        : null,
    longitude: json['longitude'] != null ? json['longitude'] as num : null,
    latitude: json['latitude'] != null ? json['latitude'] as num : null,

    checkInTime: json['checkInTime'] != null
        ? json['checkInTime'] as String
        : null,
    checkOutTime: json['checkOutTime'] != null
        ? json['checkOutTime'] as String
        : null,
    status: json['status'] != null ? json['status'] as String : null,
    isAdminActive: json['isAdminActive'] != null
        ? json['isAdminActive'] as bool
        : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    link: json['link'] != null ? json['link'] as String : null,
    isOpenYearRound: json['isOpenYearRound'] != null
        ? json['isOpenYearRound'] as bool
        : null,
    isClosed: json['isClosed'] != null ? json['isClosed'] as bool : null,

    price: json['price'] != null ? json['price'] as num : null,
    isDiscounted: json['isDiscounted'] != null
        ? json['isDiscounted'] as bool
        : null,
    isSponsored: json['isSponsored'] != null
        ? json['isSponsored'] as bool
        : null,
    avgRate: json['avgRate'] != null ? json['avgRate'] as num : null,
    totalRates: json['totalRates'] != null ? json['totalRates'] as num : null,
    savesCount: json['savesCount'] != null ? json['savesCount'] as num : null,
    capacity: json['capacity'] != null ? json['capacity'] as num : null,
    createdBy: json['createdBy'] != null ? json['createdBy'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,

    properties: json['properties'] != null
        ? (json['properties'] as List)
              .map((e) => Properties.fromJson(e))
              .toList()
        : null,
    // travelOffers: json['travelOffers'] != null
    //     ? (json['travelOffers'] as List)
    //           .map((e) => TravelOffers.fromJson(e))
    //           .toList()
    //     : null,
    placeOffers: json['placeOffers'] != null
        ? (json['placeOffers'] as List)
              .map((e) => PlaceOffers.fromJson(e))
              .toList()
        : null,
    tags: json['tags'] != null
        ? (json['tags'] as List).map((e) => Tags.fromJson(e)).toList()
        : null,
    cancelPolicies: json['cancelPolicies'] != null
        ? (json['cancelPolicies'] as List)
              .map((e) => CancelPolicyDetail.fromJson(e))
              .toList()
        : null,
    travelOffers: json['travelOffers'] != null
        ? (json['travelOffers'] as List)
              .map((e) => TravelOffersDetail.fromJson(e))
              .toList()
        : null,
  );
}

Map<String, dynamic> _$CampDataEditToJson(CampDataEdit instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.images != null) json['images'] = instance.images;
  if (instance.mainImage != null) json['mainImage'] = instance.mainImage;
  if (instance.additionalInformation != null)
    json['additionalInformation'] = instance.additionalInformation;
  if (instance.addressString != null)
    json['addressString'] = instance.addressString;
  if (instance.addressStringEng != null)
    json['addressStringEng'] = instance.addressStringEng;
  if (instance.longitude != null) json['longitude'] = instance.longitude;
  if (instance.latitude != null) json['latitude'] = instance.latitude;
  if (instance.checkInTime != null) json['checkInTime'] = instance.checkInTime;
  if (instance.checkOutTime != null)
    json['checkOutTime'] = instance.checkOutTime;
  if (instance.status != null) json['status'] = instance.status;
  if (instance.isAdminActive != null)
    json['isAdminActive'] = instance.isAdminActive;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.link != null) json['link'] = instance.link;
  if (instance.isOpenYearRound != null)
    json['isOpenYearRound'] = instance.isOpenYearRound;
  if (instance.isClosed != null) json['isClosed'] = instance.isClosed;
  if (instance.price != null) json['price'] = instance.price;
  if (instance.isDiscounted != null)
    json['isDiscounted'] = instance.isDiscounted;
  if (instance.isSponsored != null) json['isSponsored'] = instance.isSponsored;
  if (instance.avgRate != null) json['avgRate'] = instance.avgRate;
  if (instance.totalRates != null) json['totalRates'] = instance.totalRates;
  if (instance.savesCount != null) json['savesCount'] = instance.savesCount;
  if (instance.capacity != null) json['capacity'] = instance.capacity;
  if (instance.createdBy != null) json['createdBy'] = instance.createdBy;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.properties != null) json['properties'] = instance.properties;
  // if (instance.travelOffers != null)
  //   json['travelOffers'] = instance.travelOffers;
  if (instance.placeOffers != null) json['placeOffers'] = instance.placeOffers;
  if (instance.tags != null) json['tags'] = instance.tags;
  if (instance.cancelPolicies != null)
    json['cancelPolicies'] = instance.cancelPolicies;
  if (instance.travelOffers != null)
    json['travelOffers'] = instance.travelOffers;

  return json;
}
