import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/controller/refresher.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/order_card.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
// import 'package:merchant_gerbook_flutter/components/custom_comps/order_card.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/models/result.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AfterLayoutMixin {
  int filterIndex = 0;

  TextEditingController searchController = TextEditingController();

  ScrollController scrollController = ScrollController();
  int page = 1;
  int limit = 10;
  bool isLoadingPage = true;
  bool isLoadingBooking = true;
  Result bookingList = Result();
  Timer? timer;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      await listOfBookings(page, limit, status: "PENDING");
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  listOfBookings(page, limit, {String? query, String? status}) async {
    bookingList = await ProductApi().getBookingList(
      ResultArguments(
        page: page,
        limit: limit,
        query: query,
        status: status != null ? status : null,
      ),
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
    await await listOfBookings(
      page,
      limit,
      query: searchController.text,
      status: filterIndex == 0
          ? "PENDING"
          : filterIndex == 1
          ? "PAID"
          : "CANCELED",
    );
    refreshController.refreshCompleted();
  }

  onLoading() async {
    if (!mounted) return;
    setState(() {
      limit += 10;
    });
    await await listOfBookings(
      page,
      limit,
      query: searchController.text,
      status: filterIndex == 0
          ? "PENDING"
          : filterIndex == 1
          ? "PAID"
          : "CANCELED",
    );
    refreshController.loadComplete();
  }

  onChange(String query) {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      listOfBookings(page, limit, query: query);
      // setState(() {
      //   isLoadingStays = false;
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    // '${translateKey.translate('booking_status_label.${widget.data.status}')}',

    final List<String> tabs = [
      '${translateKey.translate('booking_status_label.PENDING')}',
      '${translateKey.translate('booking_status_label.PAID')}',
      '${translateKey.translate('booking_status_label.CANCELED')}',
    ];
    final Map<String, String> tabFilters = {
      '${translateKey.translate('booking_status_label.PENDING')}': "PENDING",
      '${translateKey.translate('booking_status_label.PAID')}': "PAID",
      '${translateKey.translate('booking_status_label.CANCELED')}': "CANCELED",
    };
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          shape: Border(bottom: BorderSide(color: gray200, width: 2)),
          elevation: 0,
          centerTitle: false,
          backgroundColor: white,
          automaticallyImplyLeading: false,
          title: Text(
            '${translateKey.translate('order')[0].toUpperCase()}${translateKey.translate('order').substring(1)}',
            style: TextStyle(
              color: gray800,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(32),
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 16),
                    Row(
                      children: List.generate(tabs.length, (index) {
                        final bool isSelected = filterIndex == index;
                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              filterIndex = index;
                            });
                            final selectedTab = tabs[filterIndex];
                            final filter = tabFilters[selectedTab];
                            scrollController.animateTo(
                              scrollController.position.minScrollExtent,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeOut,
                            );
                            await listOfBookings(
                              page,
                              limit,
                              query: searchController.text,
                              status: filter,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: isSelected ? primary : white,
                              border: Border.all(
                                color: isSelected ? primary : white,
                              ),
                            ),
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                color: isSelected ? white : gray800,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: FormTextField(
                      inputType: TextInputType.text,
                      controller: searchController,
                      colortext: black,
                      name: 'userName',
                      color: white,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      onChanged: (query) {
                        onChange(query);
                      },
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 10),
                          SvgPicture.asset('assets/svg/search.svg'),
                          SizedBox(width: 8),
                        ],
                      ),
                      hintText:
                          "${translateKey.translate('ger')}, ${translateKey.translate('search').toLowerCase()}",
                      hintTextColor: gray500,
                    ),
                  ),
                  SizedBox(width: 12),

                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: white,
                      border: Border.all(color: gray300),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: SvgPicture.asset('assets/svg/calendar.svg'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: Refresher(
                  refreshController: refreshController,
                  onLoading: onLoading,
                  onRefresh: onRefresh,
                  color: primary,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: isLoadingBooking == true
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
                        : Column(
                            children: [
                              ...bookingList.rows!
                                  .map(
                                    (data) => Column(
                                      children: [
                                        OrderCard(data: data),
                                        SizedBox(height: 14),
                                      ],
                                    ),
                                  )
                                  .toList(),
                              SizedBox(height: mediaQuery.padding.bottom + 24),
                            ],
                          ),

                    //  Column(
                    //   children: [
                    //     Column(
                    //       children: [1, 2, 3, 4, 5]
                    //           .map(
                    //             (item) => Column(
                    //               children: [
                    //                 // /OrderCard(),
                    //                 Text('data'),
                    //                 SizedBox(height: 12),
                    //               ],
                    //             ),
                    //           )
                    //           .toList(),
                    //     ),
                    //     SizedBox(height: mediaQuery.padding.bottom + 50),
                    //   ],
                    // ),
                  ),
                ),
              ),
              // SizedBox(height: mediaQuery.padding.bottom + 50),
            ],
          ),
        ),
      ),
    );
  }
}
