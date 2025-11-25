import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/camp_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';

class GerDetailPageArguments {
  final String id;
  GerDetailPageArguments({required this.id});
}

class GerDetailPage extends StatefulWidget {
  final String id;

  static const routeName = "GerDetailPage";
  const GerDetailPage({super.key, required this.id});

  @override
  State<GerDetailPage> createState() => _GerDetailPageState();
}

class _GerDetailPageState extends State<GerDetailPage> with AfterLayoutMixin {
  bool isLoadingPage = true;
  CampData data = CampData();
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      data = await ProductApi().getCampData(widget.id);
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
      body: isLoadingPage == true
          ? CustomLoader()
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: white,
                  pinned: false,
                  snap: false,
                  floating: true,
                  expandedHeight: 56,
                  automaticallyImplyLeading: false,
                  elevation: 0.3,
                  centerTitle: false,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/chevron_left.svg',
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  leadingWidth: 52,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${data.name ?? ''}',
                          style: TextStyle(
                            color: gray800,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset(
                          'assets/svg/dots-horizontal.svg',
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 342,
                                width: mediaQuery.size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/zurag.png',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x0F101828),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                      spreadRadius: -2,
                                    ),
                                    BoxShadow(
                                      color: Color(0x19101828),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                      spreadRadius: -2,
                                    ),
                                  ],
                                ),
                              ),
                              // Positioned(
                              //   bottom: 8,
                              //   left: 10,
                              //   height: 10,
                              //   child: Container(
                              //     decoration: ShapeDecoration(
                              //       color: white,
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadiusGeometry.all(
                              //           Radius.circular(320),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: mediaQuery.size.width,
                        padding: const EdgeInsets.all(16.0),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              translateKey.translate('Name'),
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  translateKey.translate('Kemp'),
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: gray600,
                                  ),
                                ),
                                SizedBox(width: 5),
                                SvgPicture.asset('assets/svg/dot.svg'),
                                SizedBox(width: 5),

                                Text(
                                  translateKey.translate('Bed'),
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: gray600,
                                  ),
                                ),
                                SizedBox(width: 5),
                                SvgPicture.asset('assets/svg/dot.svg'),
                                SizedBox(width: 5),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/star_filled.svg',
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      '4.5',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Terelj Star Resort is located in Gorkhi-Terelj Natural Park. It works 4 seasons a year and can accommodate 150 people at a time.',
                              style: TextStyle(
                                fontFamily: 'lato',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: gray800,
                              ),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
