import 'package:merchant_gerbook_flutter/models/address.dart';
import 'package:merchant_gerbook_flutter/models/booking_list.dart';
import 'package:merchant_gerbook_flutter/models/camp_list_data.dart';
import 'package:merchant_gerbook_flutter/models/chart_data.dart';
import 'package:merchant_gerbook_flutter/models/dashboard.dart';
import 'package:merchant_gerbook_flutter/models/notify_list.dart';
import 'package:merchant_gerbook_flutter/models/place_offers.dart';
import 'package:merchant_gerbook_flutter/models/properties.dart';
import 'package:merchant_gerbook_flutter/models/result.dart';
import 'package:merchant_gerbook_flutter/models/tags.dart';
import 'package:merchant_gerbook_flutter/models/terms_of_condition.dart';
import 'package:merchant_gerbook_flutter/models/transaction.dart';
import 'package:merchant_gerbook_flutter/utils/http_request.dart';

class ProductApi extends HttpRequest {
  getContract() async {
    var res = await get('/merchant-contract');
    return TermsOfCondition.fromJson(res as Map<String, dynamic>);
  }

  showNotification(String id) async {
    var res = await get('/notifications/$id');
    return res;
  }

  getNotification(ResultArguments resultArguments) async {
    var res = await get('/notifications', data: resultArguments.toJson());
    return Result.fromJson(res, NotifyList.fromJson);
  }

  getDashBoardData() async {
    var res = await get('/merchants/dashboard');
    return Dashboard.fromJson(res as Map<String, dynamic>);
  }

  getBookingList(ResultArguments resultArguments) async {
    var res = await get('/merchants/bookings', data: resultArguments.toJson());
    return Result.fromJson(res, BookingList.fromJson);
  }

  getmyGers(ResultArguments resultArguments) async {
    var res = await get(
      '/merchants/properties',
      data: resultArguments.toJson(),
    );
    return Result.fromJson(res, Properties.fromJson);
  }

  getOrderChart() async {
    var res = await get('/merchants/orders/chart');
    return Result.fromJson(res, ChartData.fromJson);
  }

  getProfitChart() async {
    var res = await get('/merchants/profits/chart');
    return Result.fromJson(res, ChartData.fromJson);
  }

  getTransactionList(ResultArguments resultArguments) async {
    var res = await get(
      '/merchants/transactions',
      data: resultArguments.toJson(),
    );
    return Result.fromJson(res, Transaction.fromJson);
  }

  getCampList(ResultArguments resultArguments) async {
    var res = await get('/merchants/camps', data: resultArguments.toJson());
    return Result.fromJson(res, CampListData.fromJson);
  }

  getPlaceOffersList(ResultArguments resultArguments) async {
    var res = await get('/place-offers', data: resultArguments.toJson());
    return Result.fromJson(res, PlaceOffers.fromJson);
  }

  getPlaceTags(ResultArguments resultArguments) async {
    var res = await get('/property-tags', data: resultArguments.toJson());
    return Result.fromJson(res, Tags.fromJson);
  }

  getAllPlace(ResultArguments resultArguments) async {
    var res = await get('/addresses', data: resultArguments.toJson());
    return Result.fromJson(res, Address.fromJson);
  }

  getCountryAddress(ResultArguments resultArguments) async {
    List<dynamic> jsonData = await get(
      '/addresses',
      data: resultArguments.toJson(),
    );
    return jsonData.map((item) => Address.fromJson(item)).toList();
  }

  // getOrderData(String id) async {
  //   var res = await get('/merchants/orders/chart/$id');
  //   return OrderData.fromJson(res as Map<String, dynamic>);
  // }
}
