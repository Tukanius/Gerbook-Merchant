import 'package:flutter/material.dart';
import 'package:merchant_gerbook_flutter/models/upload_image.dart';

class CampCreateProvider extends ChangeNotifier {
  UploadImage mainImage = UploadImage();
  List<UploadImage> images = [];
  String name = '';
  String description = '';

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
}
