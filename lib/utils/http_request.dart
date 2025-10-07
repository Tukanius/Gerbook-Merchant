import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:merchant_gerbook_flutter/components/dialog_component/error_dialog.dart';
import 'package:merchant_gerbook_flutter/main.dart';
import 'package:merchant_gerbook_flutter/provider/user_provider.dart';
import 'package:merchant_gerbook_flutter/services/navigation.dart';
import 'package:merchant_gerbook_flutter/src/localization/localization_local.dart';
import 'package:merchant_gerbook_flutter/src/splash_page/splash_page.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:gerbook_flutter/services/dialog.dart';
import 'http_handler.dart';
// import '../main.dart';

class HttpRequest {
  // static const host = "http://dev-cb-admin.zto.mn";
  static const host = 'https://gerbook.com';
  // static const host = 'https://gb.zto.mn';

  // static const host = 'https://app.xotsocial.mn';

  static const version = '/app';
  // static const version = '/api/mobile';

  static const uri = host;

  // static const part = "/mobile";

  Dio dio = Dio();

  Future<dynamic> request(
    String api,
    String method,
    dynamic data,
    String appType, {
    bool handler = true,
    bool approve = false,
  }) async {
    Response? response;
    final String uri;
    var token = await UserProvider.getAccessToken();

    uri = '$host$version$api';
    debugPrint(uri);

    debugPrint('+++++++++++++++++++++++++++++++++++++++++++++++++++');
    debugPrint('handler: ' + handler.toString());
    debugPrint('+++++++++++++++++++++++++++++++++++++++++++++++++++ ');
    try {
      Directory dir = await getTemporaryDirectory();
      CookieJar cookieJar = PersistCookieJar(
        storage: FileStorage(dir.path),
        ignoreExpires: true,
      );
      String? locale = await getLocale();
      if (locale == null) {
        await saveLocale('mn');
        locale = await getLocale();
      } else {
        locale = await getLocale();
      }
      dio.interceptors.add(CookieManager(cookieJar));
      cookieJar.saveFromResponse(Uri.parse('$host$version'), [
        Cookie('NEXT_LOCALE', '${locale}'),
      ]);
      var token = await UserProvider.getAccessToken();
      var deviceToken = await UserProvider.getDeviceToken();
      // debugPrint('++++++++++++++++++++++deviceToken+++++++++++++++ ');
      // debugPrint(deviceToken);
      // debugPrint('+++++++++++++++++++++++deviceToken++++++++++++++ ');
      String value = 'undefined';
      if (token != null) {
        value = 'Bearer $token';
      } else {
        value;
      }
      dio.options.headers = {
        'authorization': '$value',
        'device-token': '$deviceToken',
        'device_type': 'MOS',
        'device_imei': 'test-imei',
        'device_info': 'iphone 13',
        'app-Type': "${appType}",
        'isMobile': true,
      };
    } catch (err) {
      debugPrint(err.toString());
    }

    if (method != 'GET') {
      debugPrint('body: $data');
    }

    try {
      switch (method) {
        case 'GET':
          {
            response = await dio.get(uri, queryParameters: data);
            break;
          }
        case 'POST':
          {
            response = await dio.post(uri, data: data);
            break;
          }
        case 'PUT':
          {
            response = await dio.put(uri, data: data);
            break;
          }
        case 'DELETE':
          {
            response = await dio.delete(uri, data: data);
            break;
          }
      }

      return HttpHandler(statusCode: response?.statusCode).handle(response);
      // ignore: deprecated_member_use
    } on DioError catch (ex) {
      if (token != null && ex.response?.statusCode == 401) {
        print('====TOKEN from Ger====');
        print(token);
        print('====TOKEN from Ger====');

        MyApp.setInvalidToken(MyApp.invalidTokenCount + 1);
        if (MyApp.invalidTokenCount == 1) {
          await UserProvider().auth();
          locator<NavigationService>().pushNamed(
            routeName: SplashPage.routeName,
          );
          // NotifyService().showNotification(
          //   title: 'Green Score',
          //   body: 'Нэвтрэх эрх хүчингүй боллоо',
          // );
          MyApp.setInvalidToken(0);

          return null;
        }
        return;
      }
      // try {
      //   result = await _connectivity.checkConnectivity();
      //   if (result == ConnectivityResult.none) {
      //     MyApp.dialogService!
      //         .showInternetErrorDialog("No internet connection");
      //     return null;
      //   }
      // } on PlatformException catch (e) {
      //   debugPrint(e.toString());
      // }

      HttpHandler? error = HttpHandler(
        statusCode: ex.response?.statusCode,
      ).handle(ex.response);
      if (handler == true && error!.message != null) {
        BuildContext? context = NavigationService.navigatorKey.currentContext;
        ErrorDialog(context: context).show(error.message.toString());
      }
      throw error!;
    }
  }

  Future<dynamic> get(String url, {dynamic data, bool handler = true}) async {
    try {
      return await request(url, 'GET', data, "GER_BOOK", handler: handler);
    } catch (e) {
      debugPrint("GET =>" + e.toString());
      rethrow;
    }
  }

  Future<dynamic> post(
    String url, {
    dynamic data,
    bool handler = true,
    bool approve = false,
  }) async {
    try {
      return await request(
        url,
        'POST',
        data,
        "GER_BOOK",
        handler: handler,
        approve: approve,
      );
    } catch (e) {
      debugPrint("POST =>" + e.toString());
      rethrow;
    }
  }

  Future<dynamic> put(String url, {dynamic data, bool handler = true}) async {
    try {
      return await request(url, 'PUT', data, "GER_BOOK", handler: handler);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<dynamic> del(String url, {dynamic data, bool handler = true}) async {
    return await request(url, 'DELETE', data, "GER_BOOK", handler: handler);
  }
}
