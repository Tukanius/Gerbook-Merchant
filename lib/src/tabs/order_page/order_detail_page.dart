// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
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
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    // var res = await ProductApi().getOrderData(id);
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
          'Захиалгын дэлгэрэнгүй',
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: gray800,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 78,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage('assets/images/zurag.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nomadic stay at Orkhon Valley',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: gray800,
                            ),
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
                              Text(
                                'Увс аймаг, Бөхмөрөн сум',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: gray600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: <Widget>[
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/home.svg',
                                    width: 14,
                                    height: 14,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: gray600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: 1,
                                height: 10,
                                decoration: ShapeDecoration(
                                  color: gray600,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(320),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/heart.svg',
                                    width: 14,
                                    height: 14,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: gray600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: 1,
                                height: 10,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: gray600,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(320),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/star_filled.svg',
                                    height: 14,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    '0',
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
                          SizedBox(height: 6),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '2,000,000₮',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: primary,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                translateKey.translate('nights'),
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
                    SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/svg/chevron_right.svg',
                      height: 24,
                      color: gray800,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: mediaQuery.size.width,

              height: 2,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: gray200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(320),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Захиалгийн мэдээлэл',
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
                      SvgPicture.asset('assets/svg/clock.svg', height: 18),
                      SizedBox(width: 6),
                      Text(
                        'Захиалсан огноо',
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

                  Row(
                    children: [
                      Text(
                        '2025-03-21',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: gray600,
                        ),
                      ),
                      SizedBox(width: 2),
                      Text(
                        '10:45',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: gray600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: mediaQuery.size.width,

                    height: 1,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: gray200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(320),
                      ),
                    ),
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
                        'Захиалсан өдөр',
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

                  Row(
                    children: [
                      Text(
                        '2025-03-21',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: gray600,
                        ),
                      ),
                      SizedBox(width: 2),
                      Text(
                        '-',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: gray600,
                        ),
                      ),
                      SizedBox(width: 2),
                      Text(
                        '2025-03-21',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: gray600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: mediaQuery.size.width,

                    height: 1,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: gray200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(320),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/users.svg', height: 18),
                      SizedBox(width: 6),
                      Text(
                        'Хүрэлцэн ирэх хүний тоо',
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
                    '2',
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
                    height: 1,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: gray200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(320),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/bank_note.svg', height: 18),
                      SizedBox(width: 6),
                      Text(
                        'Төлбөр төлсөн хэрэгсэл',
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
                    'Qpay',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: gray600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: mediaQuery.size.width,

              height: 2,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: gray200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(320),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Төлбөрийн мэдээлэл',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: gray800,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Үнэ ',
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
                        '500,000₮',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: gray800,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Хоногын',
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

                    height: 1,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: gray200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(320),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Захиалсан нийт өдөр',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: gray900,
                    ),
                  ),
                  SizedBox(height: 4),

                  Text(
                    '2025-03-21',
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

                    height: 1,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: gray200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(320),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  SizedBox(width: 6),
                  Text(
                    'Хямдрал',
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
                        '10%',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: success500,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Эхний 10 захиалга',
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
            Container(
              width: mediaQuery.size.width,
              height: 2,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: gray200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(320),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    'Захиалагчийн мэдээлэл',
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
                      Container(
                        height: 40,
                        width: 40,
                        clipBehavior: Clip.hardEdge,
                        decoration: ShapeDecoration(shape: CircleBorder()),
                        child: Image.asset(
                          'assets/images/zurag.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Бат-Эрдэнэ Дуламсүрэн',
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
                                '88888888',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: gray600,
                                ),
                              ),
                              SizedBox(width: 6),
                              SvgPicture.asset('assets/svg/dot.svg', height: 4),
                              SizedBox(width: 6),
                              Text(
                                'm-ail@gmail.com',
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
                  ),
                ],
              ),
            ),
            SizedBox(height: mediaQuery.padding.bottom + 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Column(
          children: [
            Container(
              width: mediaQuery.size.width,
              height: 1,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: gray200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(320),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Нийт төлбөр',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: gray600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '500,000₮',
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
                        'B250630104',
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
                          vertical: 4,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: success600,
                          borderRadius: BorderRadius.all(Radius.circular(320)),
                        ),
                        child: Text(
                          'Төлбөр төлөгдсөн',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
model create 
api create 
get data 
 */