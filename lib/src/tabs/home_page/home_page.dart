import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool recentOrder = true;
  bool totalOrder = true;
  bool order = true;
  bool notificationdot = false;
  bool recentorder = false;
  bool myger = false;

  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: gray200, width: 2)),
        toolbarHeight: 68,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: Padding(
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
        title: SizedBox(
          width: 140,
          child: Image.asset('assets/images/homelogo.png', fit: BoxFit.cover),
        ),

        actions: [
          GestureDetector(
            onTap: () {},
            child: notificationdot == true
                ? SvgPicture.asset('assets/svg/bell.svg', height: 24)
                : Stack(
                    children: [
                      Center(
                        child: SvgPicture.asset(
                          'assets/svg/bell.svg',
                          height: 24,
                        ),
                      ),
                      Positioned(
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
                      ),
                    ],
                  ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: gray200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              translateKey.translate('transaction_type_profit'),
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: gray400,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              recentOrder == true ? '202,400₮' : '-',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: gray200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              translateKey.translate('total_orders'),
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: gray400,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              recentOrder == false ? '12' : '-',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: gray200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              translateKey.translate('sales'),
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: gray400,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              recentOrder == true ? '12,042,759₮' : '-',
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontFamily: 'Lato',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: primary,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    recentorder == false
                        ? Column(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/empty_box.svg',
                                width: 141,
                              ),
                              SizedBox(height: 16),
                              Column(
                                children: [
                                  Text(
                                    translateKey.translate('no_active_orders'),
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
                          )
                        : Text('data'),
                  ],
                ),
              ],
            ),
          ),
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
                    Row(
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
                        SizedBox(width: 2),
                        SvgPicture.asset(
                          'assets/svg/chevron_right.svg',
                          height: 18,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myger == false
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
                                  SizedBox(height: 2),
                                  Text(
                                    translateKey.translate('no_ger_please_add'),
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
                                  children: [
                                    Icon(Icons.add, color: white, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      translateKey.translate('create_listing'),
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
                            ],
                          )
                        : Text('data'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
