import 'package:flutter/material.dart';
import 'package:merchant_gerbook_flutter/models/cancel_policy.dart';
import 'package:merchant_gerbook_flutter/models/discount_types.dart';
import 'package:merchant_gerbook_flutter/models/place_offers.dart';
import 'package:merchant_gerbook_flutter/models/tags.dart';
import 'package:merchant_gerbook_flutter/models/travel_offers.dart';
import 'package:merchant_gerbook_flutter/models/upload_image.dart';

class CampCreateProvider extends ChangeNotifier {
  // camp images
  UploadImage mainImage = UploadImage();
  List<UploadImage> images = [];
  // camp name and description
  String name = '';
  String description = '';
  // camp location
  String level0 = '';
  String level1 = '';
  String level2 = '';
  String level3 = '';
  String addressDetail = '';
  String zoneId = '';
  String latitude = '';
  String longitude = '';

  // List<String> placeOffers = [];
  // List<String> tags = [];
  List<PlaceOffers> placeOffers = [];
  List<Tags> tags = [];

  bool fourSeason = false;
  String checkInTime = '';
  String checkOutTime = '';

  List<DiscountTypes> discount = [];
  List<CancelPolicy> cancelPolicy = [];
  List<TravelOffers> travelOffers = [];

  updateMainImage({required UploadImage newMainImage}) {
    mainImage = newMainImage;
    notifyListeners();
  }

  updateImages({required List<UploadImage> newImages}) {
    images = newImages;
    notifyListeners();
  }

  updateNameAndInfo({required String newName, required String newDescription}) {
    name = newName;
    description = newDescription;
    notifyListeners();
  }

  updateLevel0({required String newLevel0}) {
    level0 = newLevel0;
    notifyListeners();
  }

  updateLevel1({required String newLevel1}) {
    level1 = newLevel1;
    notifyListeners();
  }

  updateLevel2({required String newLevel2}) {
    level2 = newLevel2;
    notifyListeners();
  }

  updateLevel3({required String newLevel3}) {
    level3 = newLevel3;
    notifyListeners();
  }

  updateAddressDetail({required String newAddressDetail}) {
    addressDetail = newAddressDetail;
    notifyListeners();
  }

  updateZone({required String newZone}) {
    zoneId = newZone;
    notifyListeners();
  }

  updateLocation({required String newLatitude, required String newLongitude}) {
    latitude = newLatitude;
    longitude = newLongitude;
    notifyListeners();
  }

  updateOffers({required List<PlaceOffers> newOffers}) {
    placeOffers = newOffers;
    notifyListeners();
  }

  updateTags({required List<Tags> newTags}) {
    tags = newTags;
    notifyListeners();
  }

  updateCheckIn({required String newCheckIn}) {
    checkInTime = newCheckIn;
    notifyListeners();
  }

  updateCheckOut({required String newCheckOut}) {
    checkOutTime = newCheckOut;
    notifyListeners();
  }

  updateFourSeasong({required bool newFourSeason}) {
    fourSeason = newFourSeason;
    notifyListeners();
  }

  updateTravelOffers({required List<TravelOffers> newTravelOffers}) {
    travelOffers = newTravelOffers;
    notifyListeners();
  }

  updateDiscounts({required List<DiscountTypes> newDiscounts}) {
    discount = newDiscounts;
    notifyListeners();
  }

  updateCancelPolicy({required List<CancelPolicy> newCancelPolicy}) {
    cancelPolicy = newCancelPolicy;
    notifyListeners();
  }

  UploadImage gerMainImage = UploadImage();
  List<UploadImage> gerImages = [];
  String gerName = '';
  String gerDescription = '';
  num gerPrice = 0;
  num gerOriginalPrice = 0;
  String gerBedCount = '';
  String gerMaxPerson = '';
  String gerQuantity = '';

  updateGerMainPhoto({required UploadImage newGerMainImage}) {
    gerMainImage = newGerMainImage;
    notifyListeners();
  }

  updateGerImages({required List<UploadImage> newGerImages}) {
    gerImages = newGerImages;
    notifyListeners();
  }

  updateGerName({required String newGerName}) {
    gerName = newGerName;
    notifyListeners();
  }

  updateGerDescription({required String newGerDescription}) {
    gerDescription = newGerDescription;
    notifyListeners();
  }

  updateGerPrice({required num newGerPrice}) {
    gerPrice = newGerPrice;
    notifyListeners();
  }

  updateOriginalPrice({required num newGerOriginalPrice}) {
    gerOriginalPrice = newGerOriginalPrice;
    notifyListeners();
  }

  updateGerBed({required String newGerBed}) {
    gerBedCount = newGerBed;
    notifyListeners();
  }

  updateGerMaxPerson({required String newGerMaxPerson}) {
    gerMaxPerson = newGerMaxPerson;
    notifyListeners();
  }

  updateGerQuantity({required String newGerQuantity}) {
    gerQuantity = newGerQuantity;
    notifyListeners();
  }

  clearGer() {
    gerMainImage = UploadImage();
    gerImages = [];
    gerName = '';
    gerDescription = '';
    gerPrice = 0;
    gerOriginalPrice = 0;
    gerBedCount = '';
    gerMaxPerson = '';
    gerQuantity = '';
    notifyListeners();
  }
}
