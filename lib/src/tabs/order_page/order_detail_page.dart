// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/avatar_upload.dart';
import 'package:merchant_gerbook_flutter/models/booked_data.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

class OrderDetailPageArguments {
  final String id;
  OrderDetailPageArguments({required this.id});
}

class OrderDetailPage extends StatefulWidget {
  final String id;
  static const routeName = "OrderDetailPage";

  const OrderDetailPage({super.key, required this.id});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage>
    with AfterLayoutMixin {
  BookedData data = BookedData();
  bool isLoadingPage = true;
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      data = await ProductApi().getBookingData(widget.id);

      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: gray200, width: 2)),
        toolbarHeight: 56,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),

              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: SvgPicture.asset(
                  'assets/svg/chevron_left.svg',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          '${translateKey.translate('booking_details')}',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: gray800,
          ),
        ),
      ),
      body: isLoadingPage == true
          ? CustomLoader(loadColor: primary)
          : Stack(
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: gray200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: data.properties!
                                .map(
                                  (item) => Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          height: 78,
                                          width: 90,
                                          child: BlurHash(
                                            color: gray100,
                                            hash:
                                                '${item.property!.mainImage!.blurhash}',
                                            image:
                                                '${item.property!.mainImage!.url}',
                                            imageFit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${item.property!.name ?? ''}',
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: gray800,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 2),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/svg/map_pin.svg',
                                                  height: 14,
                                                  color: gray900,
                                                ),
                                                SizedBox(width: 2),
                                                Expanded(
                                                  child: Text(
                                                    '${item.property!.addressString}',
                                                    style: TextStyle(
                                                      fontFamily: 'Lato',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: gray600,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 6),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  '${Utils().formatCurrencyDouble(item.property?.originalPrice?.toDouble() ?? 0)}₮',
                                                  style: TextStyle(
                                                    fontFamily: 'Lato',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: primary,
                                                  ),
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  translateKey.translate(
                                                    'price',
                                                  ),
                                                  style: TextStyle(
                                                    fontFamily: 'Lato',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: gray600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(width: 8),
                                      // SvgPicture.asset(
                                      //   'assets/svg/chevron_right.svg',
                                      //   height: 24,
                                      //   color: gray800,
                                      // ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      Container(
                        width: mediaQuery.size.width,
                        height: 2,
                        color: gray200,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${translateKey.translate('booking_details')}',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: gray800,
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/clock.svg',
                                  height: 18,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  '${translateKey.translate('booked_time')}',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: gray900,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${DateFormat("yyyy-MM-dd HH:mm").format(DateTime.parse(data.createdAt!).toLocal())}',
                              // '2025-03-21',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: gray600,
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: mediaQuery.size.width,
                              color: gray200,
                              height: 1,
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/calendar_check.svg',
                                  height: 18,
                                  color: gray800,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  '${translateKey.translate('booked_date')}',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: gray900,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${DateFormat("yyyy-MM-dd").format(DateTime.parse(data.startDate!).toLocal())}  -  ${DateFormat("yyyy-MM-dd").format(DateTime.parse(data.endDate!).toLocal())}',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: gray600,
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: mediaQuery.size.width,
                              color: gray200,
                              height: 1,
                            ),
                            SizedBox(height: 16),

                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svg/users.svg',
                                  height: 18,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  '${translateKey.translate('guests')}',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: gray900,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${data.personCount}',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: gray600,
                              ),
                            ),
                            // SizedBox(height: 16),
                            // Container(
                            //   width: mediaQuery.size.width,
                            //   height: 1,
                            //   color: gray200,
                            // ),
                            // SizedBox(height: 16),
                            // Row(
                            //   children: [
                            //     SvgPicture.asset('assets/svg/bank_note.svg', height: 18),
                            //     SizedBox(width: 6),
                            //     Text(
                            //       'Төлбөр төлсөн хэрэгсэл',
                            //       style: TextStyle(
                            //         fontFamily: 'Lato',
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w400,
                            //         color: gray900,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 4),
                            // Text(
                            //   'Qpay',
                            //   style: TextStyle(
                            //     fontFamily: 'Lato',
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w400,
                            //     color: gray600,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        width: mediaQuery.size.width,
                        height: 2,
                        color: gray200,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${translateKey.translate('payment_info')}',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: gray800,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              '${translateKey.translate('price')}',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: gray900,
                              ),
                            ),
                            SizedBox(height: 4),

                            Row(
                              children: [
                                Text(
                                  // '500,000₮',
                                  '${Utils().formatCurrencyDouble(data.totalAmount?.toDouble() ?? 0)}₮',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: gray800,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  '${translateKey.translate('nights')}',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: gray600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: mediaQuery.size.width,
                              color: gray200,
                              height: 1,
                            ),
                            SizedBox(height: 16),
                            Text(
                              '${translateKey.translate('booked_nights')}',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: gray900,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${data.days}',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: gray600,
                              ),
                            ),
                            data.discount != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 16),
                                      Container(
                                        width: mediaQuery.size.width,
                                        color: gray200,
                                        height: 1,
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        '${translateKey.translate('discount')}',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: gray900,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            '${Utils().formatCurrencyDouble(data.discount?.toDouble() ?? 0)}₮',
                                            style: TextStyle(
                                              fontFamily: 'Lato',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: success500,
                                            ),
                                          ),
                                          // SizedBox(width: 6),
                                          // Text(
                                          //   'Эхний 10 захиалга',
                                          //   style: TextStyle(
                                          //     fontFamily: 'Lato',
                                          //     fontSize: 12,
                                          //     fontWeight: FontWeight.w400,
                                          //     color: gray600,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      Container(
                        width: mediaQuery.size.width,
                        height: 2,
                        color: gray200,
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${translateKey.translate('guest_info')}',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: gray800,
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                data.user?.avatar != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          child: BlurHash(
                                            color: gray100,
                                            hash:
                                                '${(data.user?.avatar as Avatar).blurhash}',
                                            image:
                                                '${(data.user?.avatar as Avatar).url}',
                                            imageFit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                            border: Border.all(color: gray300),
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              'assets/svg/user.svg',
                                            ),
                                          ),
                                        ),
                                      ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data.user!.firstName} ${data.user!.lastName}',
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: gray800,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            '${data.user?.phone ?? ''}',
                                            style: TextStyle(
                                              fontFamily: 'Lato',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: gray600,
                                            ),
                                          ),
                                          SizedBox(width: 6),
                                          SvgPicture.asset(
                                            'assets/svg/dot.svg',
                                            height: 4,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            '${data.user?.email ?? ''}',
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: mediaQuery.padding.bottom + 100),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: gray200)),
                      color: white,
                    ),
                    padding: EdgeInsets.only(
                      bottom: Platform.isIOS
                          ? MediaQuery.of(context).padding.bottom
                          : 16,
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${translateKey.translate('total_amount')}',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: gray600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${Utils().formatCurrencyDouble(data.totalAmount?.toDouble() ?? 0)}₮',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: primary,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${data.code}',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: gray600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: data.status == "PAID"
                                        ? greenSuccess
                                        : data.status == "CANCELED"
                                        ? redButton
                                        : data.status == "PENDING"
                                        ? warning500
                                        : greenSuccess,
                                  ),
                                  child: Text(
                                    '${translateKey.translate('booking_status_label.${data.status}')}',
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
      // bottomNavigationBar: BottomAppBar(
      //   height: 70,
      //   child: Column(
      //     children: [
      //       Container(
      //         width: mediaQuery.size.width,
      //         height: 1,
      //         clipBehavior: Clip.antiAlias,
      //         decoration: ShapeDecoration(
      //           color: gray200,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(320),
      //           ),
      //         ),
      //       ),
      //       Container(
      //         padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   'Нийт төлбөр',
      //                   style: TextStyle(
      //                     fontFamily: 'Lato',
      //                     fontSize: 16,
      //                     fontWeight: FontWeight.w400,
      //                     color: gray600,
      //                   ),
      //                 ),
      //                 SizedBox(height: 4),
      //                 Text(
      //                   '500,000₮',
      //                   style: TextStyle(
      //                     fontFamily: 'Lato',
      //                     fontSize: 20,
      //                     fontWeight: FontWeight.w700,
      //                     color: primary,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.end,
      //               children: [
      //                 Text(
      //                   'B250630104',
      //                   style: TextStyle(
      //                     fontFamily: 'Lato',
      //                     fontSize: 16,
      //                     fontWeight: FontWeight.w400,
      //                     color: gray600,
      //                   ),
      //                 ),
      //                 SizedBox(height: 4),
      //                 Container(
      //                   padding: EdgeInsets.symmetric(
      //                     vertical: 4,
      //                     horizontal: 10,
      //                   ),
      //                   decoration: BoxDecoration(
      //                     color: success600,
      //                     borderRadius: BorderRadius.all(Radius.circular(320)),
      //                   ),
      //                   child: Text(
      //                     'Төлбөр төлөгдсөн',
      //                     style: TextStyle(
      //                       fontFamily: 'Lato',
      //                       fontSize: 14,
      //                       fontWeight: FontWeight.w500,
      //                       color: white,
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
/*
model create 
api create 
get data 
 */