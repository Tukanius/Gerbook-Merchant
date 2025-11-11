import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class ProfilePageArguments {}

class ProfilePage extends StatefulWidget {
  final String id;
  static const routeName = "ProfilePage";

  const ProfilePage({super.key, required this.id});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AfterLayoutMixin {
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
          translateKey.translate('Profile'),
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
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 98,
                    width: 98,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/zurag.png',
                          ),
                        ),
                        Positioned(
                          bottom: -6,
                          right: -26,
                          child: RawMaterialButton(
                            onPressed: () {
                              print('Working');
                            },
                            elevation: 2,
                            fillColor: primary,
                            child: SvgPicture.asset(
                              'assets/svg/camera-plus.svg',
                              height: 20,
                            ),
                            padding: EdgeInsetsGeometry.all(8),
                            shape: CircleBorder(
                              side: BorderSide(color: white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  translateKey.translate('first_name'),

                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: gray900,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Батаа',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: gray600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            GestureDetector(
                              onTap: () {
                                print('Working');
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  translateKey.translate('zasah'),
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
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
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  translateKey.translate('last_name'),

                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: gray900,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Батаа',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: gray600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            GestureDetector(
                              onTap: () {
                                print('Working');
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  translateKey.translate('zasah'),
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: primary,
                                  ),
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
                    translateKey.translate('hereglegchiyn_medeelel'),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: gray900,
                    ),
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translateKey.translate('email'),

                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: gray900,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Data',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: gray600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              print('Working');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                translateKey.translate('zasah'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
                              ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translateKey.translate('phone_number'),

                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: gray900,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Data',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: gray600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              print('Working');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                translateKey.translate('zasah'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
                              ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translateKey.translate('registration_number'),

                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: gray900,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Data',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: gray600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              print('Working');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                translateKey.translate('zasah'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
                              ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translateKey.translate('birth_date'),

                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: gray900,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Data',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: gray600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              print('Working');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                translateKey.translate('zasah'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
                              ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translateKey.translate('gender'),

                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: gray900,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Data',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: gray600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              print('Working');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                translateKey.translate('zasah'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
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
                    translateKey.translate('soshial_holboosuud'),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: gray900,
                    ),
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/facebook.png',
                                height: 28,
                              ),

                              SizedBox(width: 8),

                              Text(
                                translateKey.translate('facebook'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: gray900,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              print('Working');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                translateKey.translate('zasah'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
                              ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/viber.png',
                                height: 28,
                              ),
                              SizedBox(width: 8),

                              Text(
                                translateKey.translate('viber'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: gray900,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              print('Working');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                translateKey.translate('zasah'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
                              ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/telegram.png',
                                height: 28,
                              ),
                              SizedBox(width: 8),

                              Text(
                                translateKey.translate('telegram'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: gray900,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              print('Working');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                translateKey.translate('zasah'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
                              ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/line.png', height: 28),
                              SizedBox(width: 8),

                              Text(
                                translateKey.translate('line'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: gray900,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              print('Working');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                translateKey.translate('zasah'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
                              ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/watsapp.png',
                                height: 28,
                              ),
                              SizedBox(width: 8),

                              Text(
                                translateKey.translate('watsapp'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: gray900,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              print('Working');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                translateKey.translate('zasah'),
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
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
          ],
        ),
      ),
    );
  }
}
