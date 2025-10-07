import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String place = '';
  String placeId = '';
  String startDate = '';
  String endDate = '';
  int person = 1;
  bool search = false;
  String type = '';

  String searchPlace = '';
  String searchId = '';

  String searchRoute = '';
  String searchRouteId = '';

  String updateRandomGer = '';

  updateRandom({
    required String newUpdateRandom,
  }) {
    updateRandomGer = newUpdateRandom;
    notifyListeners();
  }

  updatePlace({
    required String newPlace,
    required String newPlaceId,
  }) {
    place = newPlace;
    placeId = newPlaceId;
    notifyListeners();
  }

  clearPlaces() {
    updateRandomGer = '';
    place = '';
    placeId = '';
    notifyListeners();
  }

  updateRoute({
    required String newRoute,
    required String newRouteId,
  }) {
    searchRoute = newRoute;
    searchRouteId = newRouteId;
    notifyListeners();
  }

  updateStartDate({
    required String newStartDate,
  }) {
    startDate = newStartDate;
    notifyListeners();
  }

  updateEndDate({
    required String newEndDate,
  }) {
    endDate = newEndDate;
    notifyListeners();
  }
  // updateAllDate({
  //   required String newStartDate,
  //   required String newEndDate,
  // }) {
  //   startDate = newStartDate;
  //   endDate = newEndDate;
  //   notifyListeners();
  // }

  updatePerson({
    required int newPerson,
  }) {
    person = newPerson;
    notifyListeners();
  }

  setSearch(value) {
    search = value;
    notifyListeners();
  }

  updateType({
    required String newType,
  }) {
    type = newType;
  }

  clearAll() {
    place = '';
    startDate = '';
    endDate = '';
    person = 1;
    search = false;
    notifyListeners();
  }

  clearSearchPlace() {
    searchPlace = '';
    searchId = '';
    notifyListeners();
  }

  clearRoute() {
    searchRoute = '';
    searchRouteId = '';
    notifyListeners();
  }

  updateSearchPlace({
    required String newSearchPlace,
    required String newSearchId,
  }) {
    searchPlace = newSearchPlace;
    searchId = newSearchId;
    notifyListeners();
  }
}
