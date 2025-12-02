part of '../models/camp_list_data.dart';

CampListData _$CampListDataFromJson(Map<String, dynamic> json) {
  return CampListData(
    id: json['_id'] != null ? json['_id'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
    merchant: json['merchant'] != null ? json['merchant'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    description: json['description'] != null
        ? json['description'] as String
        : null,

    // property: json['property'] != null
    //     ? Properties.fromJson(json['property'])
    //     : null,
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

    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
    // payment: json['payment'] != null ? Payment.fromJson(json['payment']) : null,
    price: json['price'] != null ? json['price'] as num : null,
    capacity: json['capacity'] != null ? json['capacity'] as num : null,
  );
}

Map<String, dynamic> _$CampListDataToJson(CampListData instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  // if (instance.property != null) json['property'] = instance.property;
  // if (instance.user != null) json['user'] = instance.user;
  if (instance.code != null) json['code'] = instance.code;
  if (instance.merchant != null) json['merchant'] = instance.merchant;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.mainImage != null) json['mainImage'] = instance.mainImage;
  if (instance.additionalInformation != null)
    json['additionalInformation'] = instance.additionalInformation;
  if (instance.addressString != null)
    json['addressString'] = instance.addressString;
  if (instance.addressStringEng != null)
    json['addressStringEng'] = instance.addressStringEng;
  if (instance.longitude != null) json['longitude'] = instance.longitude;
  if (instance.latitude != null) json['latitude'] = instance.latitude;
  if (instance.merchant != null) json['merchant'] = instance.merchant;
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
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;
  if (instance.price != null) json['price'] = instance.price;
  if (instance.capacity != null) json['capacity'] = instance.capacity;
  // if (instance.payment != null) json['payment'] = instance.payment;

  return json;
}
