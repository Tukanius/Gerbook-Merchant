import 'package:flutter/material.dart';
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

  List<String> placeOffers = [];
  List<String> tags = [];

  bool fourSeason = false;
  String checkInTime = '';
  String checkOutTime = '';

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

  updateOffers({required List<String> newOffers}) {
    placeOffers = newOffers;
    notifyListeners();
  }

  updateTags({required List<String> newTags}) {
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
}
