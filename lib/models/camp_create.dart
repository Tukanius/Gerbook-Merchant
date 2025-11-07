import 'package:merchant_gerbook_flutter/models/properties.dart';

part '../parts/camp_create.dart';

class CampCreate {
  String? name;
  List<String>? images;
  String? mainImage;
  num? longitude;
  num? latitude;
  List<String>? discount;
  String? level0;
  String? level1;
  String? level2;
  String? level3;
  String? additionalInformation;
  List<String>? placeOffers;
  List<String>? discounts;
  List<String>? cancelPolicies;
  String? checkInTime;
  String? checkOutTime;
  List<String>? tags;
  bool? isOpenYearRound;
  String? zone;
  List<String>? travelOffers;
  List<Properties>? properties;
  /*
properties: Joi.array().items(Joi.object({
    name          : Joi.string().required(),
    description   : Joi.string().required(),
    images        : Joi.array().items(Joi.string().required()).required(),
    mainImage     : Joi.string().optional().allow(null),
    bedsCount     : Joi.number().required(),
    price         : Joi.number().required().min(0),
    originalPrice : Joi.number().optional().allow(null).min(0),
    maxPersonCount: Joi.number().required().min(1),
    quantity      : Joi.number().required().min(1)
  })).min(1).required()
 */

  CampCreate({
    this.name,
    this.images,
    this.mainImage,
    this.longitude,
    this.latitude,
    this.discount,
    this.level0,
    this.level1,
    this.level2,
    this.level3,
    this.additionalInformation,
    this.placeOffers,
    this.discounts,
    this.cancelPolicies,
    this.checkInTime,
    this.checkOutTime,
    this.tags,
    this.isOpenYearRound,
    this.zone,
    this.travelOffers,
    this.properties,
  });
  factory CampCreate.fromJson(Map<String, dynamic> json) =>
      _$CampCreateFromJson(json);
  Map<String, dynamic> toJson() => _$CampCreateToJson(this);
}
