import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/controller/refresher.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/notify_list.dart';
import 'package:merchant_gerbook_flutter/models/result.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/provider/user_provider.dart';
import 'package:merchant_gerbook_flutter/src/notification_page/notification_card.dart';
// import 'package:merchant_gerbook_flutter/src/notification_page/notification_card.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:gif/gif.dart';

class NotificationPage extends StatefulWidget {
  static const routeName = "NotificationPage";
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with AfterLayoutMixin, TickerProviderStateMixin {
  int page = 1;
  int limit = 10;
  bool show = false;
  bool isLoading = true;
  bool isLogin = false;
  Result data = Result();
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      isLoading = true;
      limit = 10;
    });
    await listNotify(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    setState(() {
      limit += 10;
    });
    await listNotify(page, limit);
    refreshController.loadComplete();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    var token = await UserProvider.getAccessToken();
    if (token != null) {
      setState(() {
        isLogin = true;
        listNotify(page, limit);
      });
    } else {
      setState(() {
        isLogin = false;
      });
    }
  }

  listNotify(page, limit) async {
    data = await ProductApi().getNotification(
      ResultArguments(page: page, limit: limit),
    );
    setState(() {
      isLoading = false;
    });
  }

  clickNotification(NotifyList data) async {
    print('object');
    try {
      var res = await ProductApi().showNotification(data.id!);

      print(res);
      print('123');
      // final value = await Navigator.of(context).pushNamed(
      //   BookedProperty.routeName,
      //   arguments: BookedPropertyArguments(id: data.object!.id!),
      // );
      // if (value == true) {
      //   listNotify(page, limit);
      // }
    } catch (e) {
      print(e);
    }
  }
  // late final GifController _controller = GifController(vsync: this);

  @override
  Widget build(BuildContext context) {
    final local = Provider.of<LocalizationProvider>(context);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.of(context).pop(true);
        }
      },
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            local.translate('notifications'),
            style: TextStyle(
              color: gray800,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          elevation: 0.3,
          leading: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(true);
              },
              child: SvgPicture.asset('assets/svg/chevron_left.svg'),
            ),
          ),
        ),
        backgroundColor: white,
        extendBodyBehindAppBar: isLogin == false ? true : false,
        body: isLogin == false
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Image.asset('assets/images/bg_frame.png'),
                          Center(
                            child: Column(
                              children: [
                                Image.asset('assets/images/mobile.png'),
                                SizedBox(height: 12),
                                Center(
                                  child: Text(
                                    local.translate('notify_text'),
                                    style: TextStyle(
                                      color: primary,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Center(
                                  child: Text(
                                    local.translate('notify_text_news'),
                                    style: TextStyle(
                                      color: gray800,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : isLoading == true
            ? Center(child: CustomLoader())
            : data.rows!.isEmpty == true
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Center(
                    child: Stack(
                      children: [
                        Image.asset('assets/images/bg_frame.png'),
                        Center(
                          child: Column(
                            children: [
                              Image.asset('assets/images/mobile.png'),
                              SizedBox(height: 12),
                              Center(
                                child: Text(
                                  local.translate('notify_text'),
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Center(
                                child: Text(
                                  local.translate('notify_text_news'),
                                  style: TextStyle(
                                    color: gray800,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Refresher(
                refreshController: refreshController,
                onLoading: onLoading,
                onRefresh: onRefresh,
                color: primary,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Column(
                        children: data.rows!
                            .map(
                              (item) => NotifyCard(
                                data: item,
                                onClick: () async {
                                  // await clickNotification(item);
                                },
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
