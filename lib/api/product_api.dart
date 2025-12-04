import 'package:merchant_gerbook_flutter/models/address.dart';
import 'package:merchant_gerbook_flutter/models/booked_data.dart';
import 'package:merchant_gerbook_flutter/models/booking_list.dart';
import 'package:merchant_gerbook_flutter/models/camp_create_model.dart';
// import 'package:merchant_gerbook_flutter/models/camp_data.dart';
import 'package:merchant_gerbook_flutter/models/camp_data_edit.dart';
import 'package:merchant_gerbook_flutter/models/camp_list_data.dart';
import 'package:merchant_gerbook_flutter/models/cancel_policy.dart';
import 'package:merchant_gerbook_flutter/models/chart_data.dart';
import 'package:merchant_gerbook_flutter/models/dashboard.dart';
import 'package:merchant_gerbook_flutter/models/discount_types.dart';
import 'package:merchant_gerbook_flutter/models/notify_list.dart';
import 'package:merchant_gerbook_flutter/models/place_offers.dart';
// import 'package:merchant_gerbook_flutter/models/properties.dart';
import 'package:merchant_gerbook_flutter/models/result.dart';
import 'package:merchant_gerbook_flutter/models/social_links.dart';
import 'package:merchant_gerbook_flutter/models/tags.dart';
import 'package:merchant_gerbook_flutter/models/terms_of_condition.dart';
import 'package:merchant_gerbook_flutter/models/transaction.dart';
import 'package:merchant_gerbook_flutter/models/travel_offers.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/models/zones.dart';
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

  // getmyGers(ResultArguments resultArguments) async {
  //   var res = await get(
  //     '/merchants/properties',
  //     data: resultArguments.toJson(),
  //   );
  //   return Result.fromJson(res, Properties.fromJson);
  // }

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

  getCampData(String id) async {
    var res = await get('/merchants/camps/$id');
    return CampDataEdit.fromJson(res as Map<String, dynamic>);
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

  getZones() async {
    var res = await get('/zones');
    return Result.fromJson(res, Zones.fromJson);
  }

  getTravelOffers(ResultArguments resultArguments) async {
    var res = await get('/travel-offers', data: resultArguments.toJson());
    return Result.fromJson(res, TravelOffers.fromJson);
  }

  getDiscounts(ResultArguments resultArguments) async {
    var res = await get('/discount-types', data: resultArguments.toJson());
    return Result.fromJson(res, DiscountTypes.fromJson);
  }

  getCancelPolicies(ResultArguments resultArguments) async {
    var res = await get('/cancel-policies', data: resultArguments.toJson());
    return Result.fromJson(res, CancelPolicy.fromJson);
  }

  getBookingData(String id) async {
    var res = await get('/merchants/bookings/$id');
    return BookedData.fromJson(res as Map<String, dynamic>);
  }

  putSocials(SocialLinks data) async {
    var res = await put('/merchants/socials', data: data.toJson());
    return res;
  }

  putNames(User data) async {
    var res = await put('/merchants/profile', data: data.toJson());
    return res;
  }

  putEmail(User data) async {
    var res = await put('/merchants/email', data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  putPhone(User data) async {
    var res = await put('/merchants/phone', data: data.toJson());
    return User.fromJson(res as Map<String, dynamic>);
  }

  createCampApi(CampCreateModel data) async {
    var res = await post('/camps', data: data.toJson());
    return res;
    // return User.fromJson(res as Map<String, dynamic>);
  }

  putProperty(CampCreateModel data, String id) async {
    var res = await put('/camps/$id/properties', data: data.toJson());
    return res;
  }

  getCampProperty(String id) async {
    var res = await get('/app/camps/$id/properties');
    return res;
  }

  updateCampApit(String id) async {
    var res = await get('/app/camps/$id/properties');
    return res;
  }

  // getOrderData(String id) async {
  //   var res = await get('/merchants/orders/chart/$id');
  //   return OrderData.fromJson(res as Map<String, dynamic>);
  // }
}
