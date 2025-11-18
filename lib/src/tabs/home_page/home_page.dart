import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/api/auth_api.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/controller/refresher.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/ger_card.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/order_card.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/dashboard.dart';
import 'package:merchant_gerbook_flutter/models/result.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/notification_page/notification_page.dart';
import 'package:merchant_gerbook_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(int) onChangePage;

  const HomePage({
    super.key,
    required this.scaffoldKey,
    required this.onChangePage,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin {
  bool recentOrder = true;
  bool totalOrder = true;
  bool order = true;
  bool notificationdot = false;
  bool recentorder = false;
  bool myger = false;
  ScrollController scrollController = ScrollController();
  bool isLoadingPage = true;
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  User user = User();
  Dashboard dashBoard = Dashboard();
  Result bookingList = Result();
  Result myGers = Result();
  // BookingList bookingList = BookingList();
  bool isLoadingBooking = true;
  int page = 1;
  int limit = 10;
  bool isLoadingMyGer = true;
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      user = await AuthApi().me(false);
      dashBoard = await ProductApi().getDashBoardData();
      await listOfBookings(page, 3);
      await listOfMyGers(page, limit);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  listOfMyGers(page, limit) async {
    myGers = await ProductApi().getmyGers(
      ResultArguments(page: page, limit: limit),
    );
    setState(() {
      isLoadingMyGer = false;
    });
  }

  listOfBookings(page, limit) async {
    bookingList = await ProductApi().getBookingList(
      ResultArguments(page: page, limit: limit),
    );
    setState(() {
      isLoadingBooking = false;
    });
  }

  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      limit = 10;
    });
    await listOfBookings(page, 3);
    await listOfMyGers(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    if (!mounted) return;
    setState(() {
      limit += 10;
    });
    await listOfBookings(page, 3);
    await listOfMyGers(page, limit);
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: white,
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: gray200, width: 2)),
        toolbarHeight: 68,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              widget.scaffoldKey.currentState?.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(320),
                    topRight: Radius.circular(320),
                  ),
                ),

                child: SvgPicture.asset(
                  'assets/svg/list.svg',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
        title: SizedBox(
          width: 140,
          child: Image.asset('assets/images/homelogo.png', fit: BoxFit.cover),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final value = await Navigator.of(
                context,
              ).pushNamed(NotificationPage.routeName);
              if (value == true) {
                // fetchUserData();
              }
            },
            child: Stack(
              children: [
                Center(
                  child: SvgPicture.asset('assets/svg/bell.svg', height: 24),
                ),
                notificationdot == true
                    ? Positioned(
                        top: 18,
                        right: 0,
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                            border: Border.all(
                              color: white,
                              width: 2,
                              strokeAlign: BorderSide.strokeAlignInside,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: isLoadingPage == true
          ? CustomLoader()
          : Refresher(
              refreshController: refreshController,
              onLoading: onLoading,
              onRefresh: onRefresh,
              color: primary,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: white,
                          border: Border.all(color: gray200),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SvgPicture.asset('assets/svg/wallet.svg'),
                                SizedBox(width: 4),
                                Text(
                                  '${translateKey.translate('niyt_orlogo')}',
                                  style: TextStyle(
                                    color: gray600,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '${Utils().formatCurrencyDouble(dashBoard.profit?.toDouble() ?? 0)}₮',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: primary,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        translateKey.translate('sales'),
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: gray600,
                                        ),
                                      ),
                                      Text(
                                        '${Utils().formatCurrencyDouble(dashBoard.incomingProfit?.toDouble() ?? 0)}₮',
                                        style: TextStyle(
                                          // overflow: TextOverflow.ellipsis,
                                          fontFamily: 'Lato',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 24),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          translateKey.translate(
                                            'total_orders',
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: gray600,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '${dashBoard.totalBookings ?? 0}',
                                          style: TextStyle(
                                            // overflow: TextOverflow.ellipsis,
                                            fontFamily: 'Lato',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translateKey.translate('recent_orders'),
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: gray900,
                            ),
                          ),
                          SizedBox(height: 16),
                          isLoadingBooking == true
                              ? CustomLoader()
                              : bookingList.rows?.isEmpty == true
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/empty_box.svg',
                                          width: 141,
                                        ),
                                        SizedBox(height: 16),
                                        Column(
                                          children: [
                                            Text(
                                              translateKey.translate(
                                                'no_active_orders',
                                              ),
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: gray900,
                                              ),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              translateKey.translate(
                                                'no_active_orders_at_home',
                                              ),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: gray600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Column(
                                          children: bookingList.rows!
                                              .map(
                                                (data) => Column(
                                                  children: [
                                                    OrderCard(data: data),
                                                    SizedBox(height: 14),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: Container(
                                        height: 100,
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              white.withValues(alpha: 0),
                                              white,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 16,
                                      left: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          widget.onChangePage(3);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 16,
                                              ),
                                              decoration: BoxDecoration(
                                                color: white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(32),
                                                ),
                                                border: Border.all(
                                                  color: gray300,
                                                ),
                                              ),
                                              child: Text(
                                                translateKey.translate(
                                                  'see_all',
                                                ),
                                                style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: gray700,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    Divider(color: gray200, height: 1, thickness: 2),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                translateKey.translate('my_ger'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: gray900,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.onChangePage(1);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      translateKey.translate('all'),
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: primary,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    SvgPicture.asset(
                                      'assets/svg/chevron_right.svg',
                                      height: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          isLoadingMyGer == true
                              ? CustomLoader()
                              : myGers.rows?.isEmpty == true
                              ? Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/empty_note.svg',
                                      width: 152,
                                    ),
                                    SizedBox(height: 16),
                                    Column(
                                      children: [
                                        Text(
                                          translateKey.translate('no_ger'),
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: gray900,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          translateKey.translate(
                                            'no_ger_please_add',
                                          ),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: gray600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 12,
                                        right: 16,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: white,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            translateKey.translate(
                                              'create_listing',
                                            ),
                                            style: TextStyle(
                                              fontFamily: 'Lato',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: mediaQuery.padding.bottom + 24,
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    GridView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 16.0,
                                            mainAxisSpacing: 16.0,
                                            childAspectRatio: 2 / 3,
                                          ),

                                      itemCount: myGers.rows!.length,
                                      itemBuilder: (context, index) {
                                        final stayData = myGers.rows![index];
                                        return GerCard(
                                          data: stayData,
                                          onTap: () {},
                                        );
                                      },
                                    ),
                                  ],
                                ),
                          // Column(
                          //     children: myGers.rows!
                          //         .map(
                          //           (item) => Column(
                          //             children: [
                          //               Row(
                          //                 children: [
                          //                   GerCard(),
                          //                   SizedBox(width: 14),
                          //                   GerCard(),
                          //                 ],
                          //               ),
                          //               SizedBox(height: 14),
                          //             ],
                          //           ),
                          //         )
                          //         .toList(),
                          //   ),
                        ],
                      ),
                    ),
                    SizedBox(height: mediaQuery.padding.bottom + 100),
                  ],
                ),
              ),
            ),
    );
  }
}
