// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:after_layout/after_layout.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:intl/intl.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/camp_data.dart';
import 'package:merchant_gerbook_flutter/models/images.dart';
import 'package:merchant_gerbook_flutter/models/properties.dart';
import 'package:merchant_gerbook_flutter/src/tabs/ger_page/full_screen_image.dart';
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
  int tabIndex = 0;
  int _currentIndex = 0;
  Properties? selectedProperty;

  void changeTabIndex(int index) async {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      data = await ProductApi().getCampData(widget.id);
      final uniqueUrls = <String>{};

      if (data.mainImage != null) {
        if (uniqueUrls.add(data.mainImage!.url!)) {
          setState(() {
            allImages.add(data.mainImage!);
          });
        }
      }

      for (final image in data.images ?? []) {
        if (image.url != null && uniqueUrls.add(image.url!)) {
          setState(() {
            allImages.add(image);
          });
        }
      }
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  final List<Images> allImages = [];

  CarouselSliderController carouselController = CarouselSliderController();

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
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(24),
                                    bottomRight: Radius.circular(24),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        FullScreenImage.routeName,
                                        arguments: FullScreenImageArguments(
                                          images: data.images!,
                                        ),
                                      );
                                    },
                                    child: CarouselSlider(
                                      carouselController: carouselController,
                                      items: allImages.map((data) {
                                        return Container(
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.45,
                                          child: BlurHash(
                                            color: gray100,
                                            hash: '${data.blurhash}',
                                            image: '${data.url}',
                                            imageFit: BoxFit.cover,
                                          ),
                                        );
                                        // Container(
                                        //   width: MediaQuery.of(context).size.width,
                                        //   height: MediaQuery.of(context).size.height * 0.45,
                                        //   decoration: BoxDecoration(
                                        //     image: DecorationImage(
                                        //       image: NetworkImage(data.url!),
                                        //       fit: BoxFit.cover,
                                        //     ),
                                        //   ),
                                        //   // child: Container(
                                        //   //   color: Colors.transparent,
                                        //   // ),
                                        // );
                                      }).toList(),
                                      options: CarouselOptions(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.45,
                                        // enlargeCenterPage: true,
                                        // autoPlay: true,
                                        // aspectRatio: 16 / 9,
                                        viewportFraction: 1,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            _currentIndex = index;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 16,
                                  right: 20,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 10,
                                            sigmaY: 10,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              color: Black32.withOpacity(0.5),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 4,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "${_currentIndex + 1}/${(allImages.length)}",
                                                  style: TextStyle(
                                                    color: white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  left: 0,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 56),
                                    width: MediaQuery.of(context).size.width,
                                    height: 56,
                                    // color: blue200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 20),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  'assets/svg/back_rounded.svg',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Row(
                                        //   children: [
                                        //     GestureDetector(
                                        //       onTap: isLoadingPage == true
                                        //           ? () {}
                                        //           : () async {
                                        //               final box =
                                        //                   context.findRenderObject()
                                        //                       as RenderBox?;
                                        //               await Share.share(
                                        //                 link,
                                        //                 sharePositionOrigin:
                                        //                     box!.localToGlobal(
                                        //                       offcet
                                        //                           .Offset
                                        //                           .zero,
                                        //                     ) &
                                        //                     box.size, // ← энэ хэсэг заавал байх ёстой
                                        //               );
                                        //             },
                                        //       child: SvgPicture.asset(
                                        //         'assets/svg/share.svg',
                                        //       ),
                                        //     ),
                                        //     SizedBox(width: 10),
                                        //     GestureDetector(
                                        //       onTap: isLoading == true
                                        //           ? () {}
                                        //           : () async {
                                        //               SendWishlist send =
                                        //                   SendWishlist(
                                        //                     camp:
                                        //                         '${widget.id}',
                                        //                   );
                                        //               try {
                                        //                 info =
                                        //                     await ProductApi()
                                        //                         .addWishList(
                                        //                           send,
                                        //                         );
                                        //                 setState(() {
                                        //                   if (info.success !=
                                        //                           null &&
                                        //                       info.success ==
                                        //                           true) {
                                        //                     data.isSaved =
                                        //                         !data.isSaved!;
                                        //                   }
                                        //                 });
                                        //               } catch (e) {
                                        //                 showModalBottomSheet(
                                        //                   context: context,
                                        //                   isScrollControlled:
                                        //                       true,
                                        //                   shape: RoundedRectangleBorder(
                                        //                     borderRadius:
                                        //                         BorderRadius.only(
                                        //                           topLeft:
                                        //                               Radius.circular(
                                        //                                 16,
                                        //                               ),
                                        //                           topRight:
                                        //                               Radius.circular(
                                        //                                 16,
                                        //                               ),
                                        //                         ),
                                        //                   ),
                                        //                   isDismissible: true,
                                        //                   backgroundColor:
                                        //                       transparent,
                                        //                   builder: (context) {
                                        //                     return AuthModal(
                                        //                       onSave: () async {
                                        //                         Navigator.of(
                                        //                           context,
                                        //                         ).pop(true);
                                        //                         Navigator.of(
                                        //                           context,
                                        //                         ).pushNamed(
                                        //                           MainPage
                                        //                               .routeName,
                                        //                           arguments:
                                        //                               MainPageArguments(
                                        //                                 changeIndex:
                                        //                                     4,
                                        //                               ),
                                        //                         );
                                        //                       },
                                        //                     );
                                        //                   },
                                        //                 );
                                        //               }
                                        //             },
                                        //       child: Container(
                                        //         height: 28,
                                        //         width: 28,
                                        //         padding: const EdgeInsets.all(
                                        //           4.0,
                                        //         ),
                                        //         decoration: BoxDecoration(
                                        //           borderRadius:
                                        //               BorderRadius.circular(
                                        //                 100,
                                        //               ),
                                        //           color: grayAccent,
                                        //         ),
                                        //         child: SvgPicture.asset(
                                        //           data.isSaved == true
                                        //               ? 'assets/svg/like.svg'
                                        //               : 'assets/svg/unlike.svg',
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     SizedBox(width: 20),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    '${data.name}',
                                    style: TextStyle(
                                      color: blackText,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        data.avgRate == 0
                                            ? 'assets/svg/star.svg'
                                            : 'assets/svg/starred.svg',
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        '${data.avgRate == 0 || data.avgRate == null ? translateKey.translate('new') : data.avgRate!.toStringAsFixed(1)}',
                                        style: TextStyle(
                                          color: black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                ],
                              ),
                            ),
                            // data.tags == null
                            //     ? SizedBox()
                            //     : SingleChildScrollView(
                            //         scrollDirection: Axis.horizontal,
                            //         child: Row(
                            //           children: [
                            //             SizedBox(width: 16),
                            //             ...data.tags!
                            //                 .map(
                            //                   (item) => Row(
                            //                     children: [
                            //                       Container(
                            //                         decoration: BoxDecoration(
                            //                           borderRadius:
                            //                               BorderRadius.circular(
                            //                                 6,
                            //                               ),
                            //                           color: gray100,
                            //                           border: Border.all(
                            //                             color: gray100,
                            //                           ),
                            //                         ),
                            //                         padding:
                            //                             EdgeInsets.symmetric(
                            //                               horizontal: 6,
                            //                               vertical: 2,
                            //                             ),
                            //                         child: Text(
                            //                           translateKey.translate(
                            //                             '${item.name}',
                            //                           ),
                            //                           // '${item.name}',
                            //                           style: TextStyle(
                            //                             color: black,
                            //                             fontSize: 14,
                            //                             fontWeight:
                            //                                 FontWeight.w500,
                            //                           ),
                            //                         ),
                            //                       ),
                            //                       SizedBox(width: 6),
                            //                     ],
                            //                   ),
                            //                 )
                            //                 .toList(),
                            //             SizedBox(width: 10),
                            //           ],
                            //         ),
                            //       ),
                            SizedBox(height: 12),
                            Padding(
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 16,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: gray100,
                                ),
                                padding: EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          changeTabIndex(0);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            color: tabIndex == 0
                                                ? white
                                                : gray100,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                translateKey.translate(
                                                  'only_detail',
                                                ),
                                                style: TextStyle(
                                                  color: gray800,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          changeTabIndex(1);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            color: tabIndex == 1
                                                ? white
                                                : gray100,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                translateKey.translate('stays'),
                                                style: TextStyle(
                                                  color: gray800,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            tabIndex == 0
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 16),
                                            Text(
                                              translateKey.translate(
                                                'description',
                                              ),
                                              style: TextStyle(
                                                color: gray800,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              '${data.description}',
                                              style: TextStyle(
                                                color: gray103,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            // Wrap(
                                            //   spacing: 8,
                                            //   runSpacing: 8,
                                            //   children: [
                                            //     if (data.placeOffers != null)
                                            //       ...data.placeOffers!
                                            //           .map(
                                            //             (item) => Container(
                                            //               width: 70,
                                            //               child: Column(
                                            //                 mainAxisSize:
                                            //                     MainAxisSize
                                            //                         .min,
                                            //                 crossAxisAlignment:
                                            //                     CrossAxisAlignment
                                            //                         .start,
                                            //                 children: [
                                            //                   Container(
                                            //                     height: 50,
                                            //                     width: 50,
                                            //                     padding:
                                            //                         EdgeInsets.all(
                                            //                           12,
                                            //                         ),
                                            //                     decoration: BoxDecoration(
                                            //                       shape: BoxShape
                                            //                           .circle,
                                            //                       // color: gray101,
                                            //                       border: Border.all(
                                            //                         color:
                                            //                             gray101,
                                            //                       ),
                                            //                     ),
                                            //                     child: Center(
                                            //                       child: Image.network(
                                            //                         '${item.image!.url}',
                                            //                         height: 28,
                                            //                         width: 28,
                                            //                         cacheWidth:
                                            //                             28,
                                            //                         cacheHeight:
                                            //                             28,
                                            //                         fit: BoxFit
                                            //                             .contain,
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                   SizedBox(
                                            //                     height: 5,
                                            //                   ),
                                            //                   Text(
                                            //                     translateKey.translate(
                                            //                       '${item.name}',
                                            //                     ),
                                            //                     // '${item.name}',
                                            //                     style: TextStyle(
                                            //                       color: black,
                                            //                       fontSize: 12,
                                            //                       fontWeight:
                                            //                           FontWeight
                                            //                               .w500,
                                            //                     ),
                                            //                   ),
                                            //                 ],
                                            //               ),
                                            //             ),
                                            //           )
                                            //           .toList(),
                                            //   ],
                                            // ),
                                            SizedBox(height: 20),
                                            Text(
                                              translateKey.translate(
                                                'payment_methods',
                                              ),
                                              style: TextStyle(
                                                color: blackText,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              width: MediaQuery.of(
                                                context,
                                              ).size.width,
                                              child: Wrap(
                                                spacing: 8,
                                                runSpacing: 8,
                                                alignment:
                                                    WrapAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        color: white,
                                                        border: Border.all(
                                                          color: gray300,
                                                        ),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                            vertical: 9,
                                                          ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/svg/card.svg',
                                                            height: 18,
                                                            width: 18,
                                                          ),
                                                          SizedBox(width: 6),
                                                          Text(
                                                            '${translateKey.translate('card')}',
                                                            style: TextStyle(
                                                              color: gray800,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Image.asset(
                                                    'assets/images/2xqpay.png',
                                                    height: 36,
                                                  ),
                                                  Image.asset(
                                                    'assets/images/2xwechat.png',
                                                    height: 36,
                                                  ),
                                                  Image.asset(
                                                    'assets/images/2xapple_pay.png',
                                                    height: 36,
                                                  ),
                                                  Image.asset(
                                                    'assets/images/2xpocket.png',
                                                    height: 36,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              translateKey.translate(
                                                'check_in_out',
                                              ),
                                              style: TextStyle(
                                                color: blackText,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              width: MediaQuery.of(
                                                context,
                                              ).size.width,
                                              child: Wrap(
                                                spacing: 8,
                                                runSpacing: 8,
                                                alignment:
                                                    WrapAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/svg/time.svg',
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        '${translateKey.translate('check_in')} ${DateFormat('HH:mm').format(DateTime.parse(data.checkInTime!).toLocal())}',
                                                        style: TextStyle(
                                                          color: gray103,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/svg/time.svg',
                                                      ),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        '${translateKey.translate('check_out')} ${DateFormat('HH:mm').format(DateTime.parse(data.checkOutTime!).toLocal())}',
                                                        style: TextStyle(
                                                          color: gray103,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  tabIndex = 1;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: gray104,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/svg/calendar.svg',
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        '${DateFormat('MMM - dd').format(DateTime.now())}',
                                                        style: TextStyle(
                                                          color: gray104,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 18),
                                            Container(
                                              height: 1,
                                              width: MediaQuery.of(
                                                context,
                                              ).size.width,
                                              color: dividerColor,
                                            ),
                                            SizedBox(height: 18),
                                            Text(
                                              translateKey.translate(
                                                'location',
                                              ),
                                              style: TextStyle(
                                                color: gray800,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            // ClipRRect(
                                            //   borderRadius:
                                            //       BorderRadius.circular(15),
                                            //   child: Container(
                                            //     width: MediaQuery.of(
                                            //       context,
                                            //     ).size.width,
                                            //     height: 200,
                                            //     child: MapLibreMap(
                                            //       styleString:
                                            //           'assets/map_style.json',
                                            //       onMapCreated: (controller) async {
                                            //         mapController = controller;

                                            //         final ByteData
                                            //         bytes = await rootBundle.load(
                                            //           'assets/images/map_drop.png',
                                            //         );
                                            //         final Uint8List list = bytes
                                            //             .buffer
                                            //             .asUint8List();
                                            //         await controller.addImage(
                                            //           'custom-marker',
                                            //           list,
                                            //         );
                                            //         await mapController
                                            //             ?.addSymbol(
                                            //               SymbolOptions(
                                            //                 geometry: LatLng(
                                            //                   data.latitude!
                                            //                       .toDouble(),
                                            //                   data.longitude!
                                            //                       .toDouble(),
                                            //                 ),
                                            //                 iconImage:
                                            //                     'custom-marker',
                                            //                 iconSize: 3,
                                            //               ),
                                            //             );
                                            //       },
                                            //       onMapClick:
                                            //           (point, coordinates) {
                                            //             _launchGoogleMaps(
                                            //               data.latitude!
                                            //                   .toDouble(),
                                            //               data.longitude!
                                            //                   .toDouble(),
                                            //             );
                                            //           },
                                            //       initialCameraPosition: CameraPosition(
                                            //         target: isLoading == true
                                            //             ? LatLng(
                                            //                 // data.latitude!.toDouble(),
                                            //                 // data.latitude!.toDouble(),
                                            //                 47.9189,
                                            //                 106.9170,
                                            //               )
                                            //             : LatLng(
                                            //                 data.latitude!
                                            //                     .toDouble(),
                                            //                 data.longitude!
                                            //                     .toDouble(),
                                            //               ),
                                            //         zoom: 12.0,
                                            //       ),
                                            //       myLocationEnabled: false,
                                            //       compassEnabled: false,
                                            //       zoomGesturesEnabled: false,
                                            //       scrollGesturesEnabled: false,
                                            //       attributionButtonMargins:
                                            //           const Point(-100, -100),
                                            //       attributionButtonPosition:
                                            //           AttributionButtonPosition
                                            //               .topLeft,
                                            //     ),
                                            //   ),
                                            // ),
                                            SizedBox(height: 10),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/svg/map_pin.svg',
                                                  width: 18,
                                                  height: 18,
                                                  color: gray103,
                                                ),
                                                SizedBox(width: 5),
                                                Expanded(
                                                  child: Text(
                                                    '${data.addressString}',
                                                    style: TextStyle(
                                                      color: gray103,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16),
                                            Divider(color: gray400),
                                            SizedBox(height: 16),
                                            // reviewes.rows?.isEmpty == true ||
                                            //         reviewes.rows == null
                                            //     ? Column(
                                            //         children: [
                                            //           Row(
                                            //             mainAxisAlignment:
                                            //                 MainAxisAlignment
                                            //                     .spaceBetween,
                                            //             children: [
                                            //               Text(
                                            //                 translateKey
                                            //                     .translate(
                                            //                       'reviews',
                                            //                     ),
                                            //                 style: TextStyle(
                                            //                   color: gray800,
                                            //                   fontSize: 18,
                                            //                   fontWeight:
                                            //                       FontWeight
                                            //                           .w600,
                                            //                 ),
                                            //               ),
                                            //               Text(
                                            //                 '${data.totalRates != null ? data.totalRates : 0} ${translateKey.translate('reviews')}',
                                            //                 style: TextStyle(
                                            //                   color: blackText,
                                            //                   fontSize: 14,
                                            //                   fontWeight:
                                            //                       FontWeight
                                            //                           .w500,
                                            //                 ),
                                            //               ),
                                            //             ],
                                            //           ),
                                            //           SizedBox(height: 12),
                                            //           Container(
                                            //             width: MediaQuery.of(
                                            //               context,
                                            //             ).size.width,
                                            //             padding: EdgeInsets.all(
                                            //               12,
                                            //             ),
                                            //             decoration: BoxDecoration(
                                            //               borderRadius:
                                            //                   BorderRadius.circular(
                                            //                     8,
                                            //                   ),
                                            //               color: gray100,
                                            //             ),
                                            //             child: Text(
                                            //               translateKey.translate(
                                            //                 'must_order_review',
                                            //               ),
                                            //               style: TextStyle(
                                            //                 color: blackText,
                                            //                 fontSize: 14,
                                            //                 fontWeight:
                                            //                     FontWeight.w400,
                                            //               ),
                                            //               textAlign:
                                            //                   TextAlign.center,
                                            //             ),
                                            //           ),
                                            //         ],
                                            //       )
                                            //     : Column(
                                            //         crossAxisAlignment:
                                            //             CrossAxisAlignment
                                            //                 .start,
                                            //         children: [
                                            //           Text(
                                            //             translateKey.translate(
                                            //               'reviews',
                                            //             ),
                                            //             style: TextStyle(
                                            //               color: gray800,
                                            //               fontSize: 18,
                                            //               fontWeight:
                                            //                   FontWeight.w600,
                                            //             ),
                                            //           ),
                                            //           SizedBox(height: 8),
                                            //           Row(
                                            //             mainAxisAlignment:
                                            //                 MainAxisAlignment
                                            //                     .spaceBetween,
                                            //             children: [
                                            //               Row(
                                            //                 crossAxisAlignment:
                                            //                     CrossAxisAlignment
                                            //                         .end,
                                            //                 children: [
                                            //                   Text(
                                            //                     '${data.avgRate == 0 ? translateKey.translate('new') : data.avgRate!.toStringAsFixed(1)}',
                                            //                     style: TextStyle(
                                            //                       color:
                                            //                           blackText,
                                            //                       fontSize: 36,
                                            //                       fontWeight:
                                            //                           FontWeight
                                            //                               .w600,
                                            //                     ),
                                            //                   ),
                                            //                   SizedBox(
                                            //                     width: 8,
                                            //                   ),
                                            //                   Column(
                                            //                     children: [
                                            //                       SvgPicture.asset(
                                            //                         'assets/svg/starred.svg',
                                            //                         width: 24,
                                            //                         height: 24,
                                            //                       ),
                                            //                       SizedBox(
                                            //                         height: 8,
                                            //                       ),
                                            //                     ],
                                            //                   ),
                                            //                 ],
                                            //               ),
                                            //               Text(
                                            //                 '${data.totalRates != null ? data.totalRates : 0} ${translateKey.translate('reviews')}',
                                            //                 style: TextStyle(
                                            //                   color: blackText,
                                            //                   fontSize: 14,
                                            //                   fontWeight:
                                            //                       FontWeight
                                            //                           .w500,
                                            //                 ),
                                            //               ),
                                            //             ],
                                            //           ),
                                            //           SizedBox(height: 20),
                                            //           Column(
                                            //             children: reviewes.rows!
                                            //                 .take(2)
                                            //                 .map(
                                            //                   (review) =>
                                            //                       ReviewCard(
                                            //                         data:
                                            //                             review,
                                            //                       ),
                                            //                 )
                                            //                 .toList(),
                                            //           ),
                                            //           reviewes.rows!.isEmpty ==
                                            //                   true
                                            //               ? SizedBox()
                                            //               : GestureDetector(
                                            //                   onTap: () {
                                            //                     showModalBottomSheet(
                                            //                       context:
                                            //                           context,
                                            //                       isScrollControlled:
                                            //                           true,
                                            //                       shape: RoundedRectangleBorder(
                                            //                         borderRadius: BorderRadius.only(
                                            //                           topLeft:
                                            //                               Radius.circular(
                                            //                                 16,
                                            //                               ),
                                            //                           topRight:
                                            //                               Radius.circular(
                                            //                                 16,
                                            //                               ),
                                            //                         ),
                                            //                       ),
                                            //                       backgroundColor:
                                            //                           transparent,
                                            //                       builder: (context) {
                                            //                         return ShowAllReview(
                                            //                           data:
                                            //                               reviewes,
                                            //                         );
                                            //                       },
                                            //                     );
                                            //                   },
                                            //                   child: Container(
                                            //                     decoration: BoxDecoration(
                                            //                       borderRadius:
                                            //                           BorderRadius.circular(
                                            //                             20,
                                            //                           ),
                                            //                       border: Border.all(
                                            //                         color:
                                            //                             gray104,
                                            //                       ),
                                            //                     ),
                                            //                     padding:
                                            //                         EdgeInsets.symmetric(
                                            //                           vertical:
                                            //                               12,
                                            //                         ),
                                            //                     child: Center(
                                            //                       child: Text(
                                            //                         translateKey
                                            //                             .translate(
                                            //                               'show_all',
                                            //                             ),
                                            //                         style: TextStyle(
                                            //                           color:
                                            //                               gray104,
                                            //                           fontSize:
                                            //                               14,
                                            //                           fontWeight:
                                            //                               FontWeight
                                            //                                   .w500,
                                            //                         ),
                                            //                       ),
                                            //                     ),
                                            //                   ),
                                            //                 ),
                                            //         ],
                                            //       ),
                                            SizedBox(height: 16),
                                            Divider(color: gray400),
                                            SizedBox(height: 16),
                                            Text(
                                              translateKey.translate(
                                                'cancellation_policy',
                                              ),
                                              style: TextStyle(
                                                color: gray800,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            // data.cancelPolicies!.isEmpty == true
                                            //     ? Container(
                                            //         width: MediaQuery.of(
                                            //           context,
                                            //         ).size.width,
                                            //         padding: EdgeInsets.all(12),
                                            //         decoration: BoxDecoration(
                                            //           border: Border.all(
                                            //             color: gray200,
                                            //           ),
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                 8,
                                            //               ),
                                            //           color: white,
                                            //         ),
                                            //         child: Text(
                                            //           translateKey.translate(
                                            //             'anytime_cancel',
                                            //           ),
                                            //           style: TextStyle(
                                            //             color: primary,
                                            //             fontSize: 14,
                                            //             fontWeight:
                                            //                 FontWeight.w400,
                                            //           ),
                                            //           textAlign:
                                            //               TextAlign.center,
                                            //         ),
                                            //       )
                                            //     : data.cancelPolicies!.every(
                                            //         (item) => item.rate == 0,
                                            //       )
                                            //     ? Container(
                                            //         width: MediaQuery.of(
                                            //           context,
                                            //         ).size.width,
                                            //         padding: EdgeInsets.all(12),
                                            //         decoration: BoxDecoration(
                                            //           border: Border.all(
                                            //             color: gray200,
                                            //           ),
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                 8,
                                            //               ),
                                            //           color: white,
                                            //         ),
                                            //         child: Text(
                                            //           translateKey.translate(
                                            //             'no_refund',
                                            //           ),
                                            //           style: TextStyle(
                                            //             color: blackText,
                                            //             fontSize: 14,
                                            //             fontWeight:
                                            //                 FontWeight.w400,
                                            //           ),
                                            //           textAlign:
                                            //               TextAlign.center,
                                            //         ),
                                            //       )
                                            //     : data.cancelPolicies!.every(
                                            //         (item) => item.rate == 100,
                                            //       )
                                            //     ? Container(
                                            //         width: MediaQuery.of(
                                            //           context,
                                            //         ).size.width,
                                            //         padding: EdgeInsets.all(12),
                                            //         decoration: BoxDecoration(
                                            //           border: Border.all(
                                            //             color: gray200,
                                            //           ),
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                 8,
                                            //               ),
                                            //           color: white,
                                            //         ),
                                            //         child: Text(
                                            //           translateKey.translate(
                                            //             'anytime_cancel',
                                            //           ),
                                            //           style: TextStyle(
                                            //             color: blackText,
                                            //             fontSize: 14,
                                            //             fontWeight:
                                            //                 FontWeight.w400,
                                            //           ),
                                            //           textAlign:
                                            //               TextAlign.center,
                                            //         ),
                                            //       )
                                            //     : Column(
                                            //         crossAxisAlignment:
                                            //             CrossAxisAlignment
                                            //                 .start,
                                            //         children: [
                                            //           Column(
                                            //             children: data
                                            //                 .cancelPolicies!
                                            //                 .map(
                                            //                   (item) => Column(
                                            //                     children: [
                                            //                       Container(
                                            //                         width: MediaQuery.of(
                                            //                           context,
                                            //                         ).size.width,
                                            //                         padding: EdgeInsets.symmetric(
                                            //                           horizontal:
                                            //                               12,
                                            //                           vertical:
                                            //                               10,
                                            //                         ),
                                            //                         decoration: BoxDecoration(
                                            //                           borderRadius:
                                            //                               BorderRadius.circular(
                                            //                                 8,
                                            //                               ),
                                            //                           color:
                                            //                               white,
                                            //                           border: Border.all(
                                            //                             color:
                                            //                                 gray200,
                                            //                           ),
                                            //                         ),
                                            //                         child: Row(
                                            //                           mainAxisAlignment:
                                            //                               MainAxisAlignment
                                            //                                   .spaceBetween,
                                            //                           children: [
                                            //                             Expanded(
                                            //                               child: Column(
                                            //                                 crossAxisAlignment:
                                            //                                     CrossAxisAlignment.start,
                                            //                                 children: [
                                            //                                   Text(
                                            //                                     '${translateKey.translate('${item.cancelPolicy?.name}')}',
                                            //                                     style: TextStyle(
                                            //                                       color: gray800,
                                            //                                       fontSize: 14,
                                            //                                       fontWeight: FontWeight.w600,
                                            //                                     ),
                                            //                                   ),
                                            //                                   SizedBox(
                                            //                                     height: 6,
                                            //                                   ),
                                            //                                   Text(
                                            //                                     item.cancelPolicy?.start ==
                                            //                                             0
                                            //                                         ? '${translateKey.translate('24 цагийн өмнө цуцлах бол_description')}'
                                            //                                         : item.cancelPolicy?.start ==
                                            //                                               2
                                            //                                         ? '${translateKey.translate('2 - 7 хоногийн өмнө цуцлах бол_description')}'
                                            //                                         : item.cancelPolicy?.start ==
                                            //                                               8
                                            //                                         ? '${translateKey.translate('8 - 14 хоногийн өмнө цуцлах бол_description')}'
                                            //                                         : '${translateKey.translate('15-аас дээш хоногийн өмнө цуцлах бол_description')}',
                                            //                                     style: TextStyle(
                                            //                                       color: gray600,
                                            //                                       fontSize: 12,
                                            //                                       fontWeight: FontWeight.w500,
                                            //                                     ),
                                            //                                   ),
                                            //                                 ],
                                            //                               ),
                                            //                             ),
                                            //                             SizedBox(
                                            //                               width:
                                            //                                   10,
                                            //                             ),
                                            //                             Text(
                                            //                               '${item.rate}%',
                                            //                               style: TextStyle(
                                            //                                 color:
                                            //                                     item.rate ==
                                            //                                         100
                                            //                                     ? primary
                                            //                                     : warningColor,
                                            //                                 fontSize:
                                            //                                     20,
                                            //                                 fontWeight:
                                            //                                     FontWeight.w700,
                                            //                               ),
                                            //                             ),
                                            //                           ],
                                            //                         ),
                                            //                       ),
                                            //                       SizedBox(
                                            //                         height: 12,
                                            //                       ),
                                            //                     ],
                                            //                   ),
                                            //                 )
                                            //                 .toList(),
                                            //           ),
                                            //         ],
                                            //       ),
                                            SizedBox(height: 16),
                                            // InkWell(
                                            //   onTap: () {
                                            //     showModalBottomSheet(
                                            //       context: context,
                                            //       isScrollControlled: true,
                                            //       shape: RoundedRectangleBorder(
                                            //         borderRadius:
                                            //             BorderRadius.only(
                                            //               topLeft:
                                            //                   Radius.circular(
                                            //                     16,
                                            //                   ),
                                            //               topRight:
                                            //                   Radius.circular(
                                            //                     16,
                                            //                   ),
                                            //             ),
                                            //       ),
                                            //       builder: (context) {
                                            //         return HouseRulesSheet(
                                            //           data: data,
                                            //         );
                                            //       },
                                            //     );
                                            //   },
                                            //   child: Row(
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment
                                            //             .spaceBetween,
                                            //     children: [
                                            //       Expanded(
                                            //         child: Column(
                                            //           crossAxisAlignment:
                                            //               CrossAxisAlignment
                                            //                   .start,
                                            //           children: [
                                            //             Text(
                                            //               translateKey
                                            //                   .translate(
                                            //                     'house_rules',
                                            //                   ),
                                            //               style: TextStyle(
                                            //                 color: gray800,
                                            //                 fontSize: 18,
                                            //                 fontWeight:
                                            //                     FontWeight.w600,
                                            //               ),
                                            //             ),
                                            //             SizedBox(height: 8),
                                            //             Text(
                                            //               translateKey
                                            //                   .translate(
                                            //                     'care_respect',
                                            //                   ),
                                            //               style: TextStyle(
                                            //                 color: gray103,
                                            //                 fontSize: 14,
                                            //                 fontWeight:
                                            //                     FontWeight.w400,
                                            //               ),
                                            //             ),
                                            //           ],
                                            //         ),
                                            //       ),
                                            //       SizedBox(width: 10),
                                            //       Row(
                                            //         children: [
                                            //           SvgPicture.asset(
                                            //             'assets/svg/chevron.svg',
                                            //             width: 20,
                                            //             height: 20,
                                            //             color: gray103,
                                            //           ),
                                            //           SizedBox(width: 5),
                                            //         ],
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                            SizedBox(height: 16),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: mediaQuery.padding.bottom + 100,
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 16),
                                        data.properties?.isEmpty == true
                                            ? Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text(
                                                    '${translateKey.translate('no_results_found')}',
                                                    style: TextStyle(
                                                      color: gray800,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Column(
                                                children: data.properties!.map((
                                                  item,
                                                ) {
                                                  final bool isSelected =
                                                      selectedProperty == item;
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          color: white,
                                                          border: Border.all(
                                                            color: gray200,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                          12,
                                                                        ),
                                                                    topRight:
                                                                        Radius.circular(
                                                                          12,
                                                                        ),
                                                                  ),
                                                              child: Container(
                                                                width:
                                                                    mediaQuery
                                                                        .size
                                                                        .width,
                                                                height: 210,
                                                                child: BlurHash(
                                                                  color:
                                                                      gray100,
                                                                  hash:
                                                                      '${item.mainImage!.blurhash}',
                                                                  image:
                                                                      '${item.mainImage!.url}',
                                                                  imageFit:
                                                                      BoxFit
                                                                          .cover,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                    6,
                                                                  ),
                                                              child: Text(
                                                                '${item.name!}',
                                                                style: TextStyle(
                                                                  color: black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 2),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          8,
                                                                        ),
                                                                    color:
                                                                        white,
                                                                    border: Border.all(
                                                                      color:
                                                                          gray200,
                                                                    ),
                                                                  ),
                                                                  padding:
                                                                      EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            6,
                                                                      ),
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture.asset(
                                                                        'assets/svg/bed_icon.svg',
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            6,
                                                                      ),
                                                                      Text(
                                                                        '${item.bedsCount ?? '-'} ${translateKey.translate('beds')}',
                                                                        style: TextStyle(
                                                                          color:
                                                                              black,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          8,
                                                                        ),
                                                                    color:
                                                                        white,
                                                                    border: Border.all(
                                                                      color:
                                                                          gray200,
                                                                    ),
                                                                  ),
                                                                  padding:
                                                                      EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            6,
                                                                      ),
                                                                  child: Row(
                                                                    children: [
                                                                      SvgPicture.asset(
                                                                        'assets/svg/person_icon.svg',
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            6,
                                                                      ),
                                                                      Text(
                                                                        '${item.maxPersonCount ?? '-'} ${translateKey.translate('person')}',
                                                                        style: TextStyle(
                                                                          color:
                                                                              black,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: 2),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  if (selectedProperty ==
                                                                      item) {
                                                                    selectedProperty =
                                                                        null;
                                                                  } else {
                                                                    selectedProperty =
                                                                        item;
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                margin:
                                                                    EdgeInsets.all(
                                                                      6,
                                                                    ),
                                                                decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        8,
                                                                      ),
                                                                  color:
                                                                      isSelected
                                                                      ? gray200
                                                                      : primary,
                                                                ),
                                                                padding:
                                                                    EdgeInsets.symmetric(
                                                                      vertical:
                                                                          8,
                                                                    ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      '${translateKey.translate('book_now')}: ',
                                                                      style: TextStyle(
                                                                        color:
                                                                            isSelected
                                                                            ? gray104
                                                                            : white,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                    // item.originalPrice !=
                                                                    //         null
                                                                    //     ? Text(
                                                                    //         ' ${translateKey.formatCurrency(item.originalPrice?.toDouble() ?? 0)} ',
                                                                    //         style: TextStyle(
                                                                    //           color: gray300,
                                                                    //           fontSize: 12,
                                                                    //           fontWeight: FontWeight.w400,
                                                                    //           decoration: TextDecoration.lineThrough,
                                                                    //         ),
                                                                    //       )
                                                                    //     : SizedBox(),
                                                                    // Text(
                                                                    //   '${translateKey.formatCurrency(item.price?.toDouble() ?? 0)}',
                                                                    //   style: TextStyle(
                                                                    //     color:
                                                                    //         isSelected
                                                                    //         ? gray104
                                                                    //         : white,
                                                                    //     fontSize:
                                                                    //         14,
                                                                    //     fontWeight:
                                                                    //         FontWeight.w600,
                                                                    //   ),
                                                                    // ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 12),
                                                    ],
                                                  );
                                                }).toList(),
                                              ),

                                        // Column(
                                        //   children: stays.rows!
                                        //       .map(
                                        //         (item) => Column(
                                        //           children: [
                                        //             StaysCard(
                                        //               data: item,
                                        //               onClick: () {
                                        //                 Navigator.of(context).pushNamed(
                                        //                   StaysDetailPage.routeName,
                                        //                   arguments: StaysDetailPageArguments(
                                        //                     id: item.id,
                                        //                   ),
                                        //                 );
                                        //               },
                                        //             ),
                                        //             SizedBox(
                                        //               height: 16,
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       )
                                        //       .toList(),
                                        // ),
                                        SizedBox(
                                          height:
                                              mediaQuery.padding.bottom + 100,
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      tabIndex == 0
                          ? SizedBox()
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Black10,
                                      blurRadius: 12,
                                      offset: ui.Offset(0, -1),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.only(
                                  bottom: Platform.isIOS
                                      ? MediaQuery.of(context).padding.bottom
                                      : 16,
                                  left: 16,
                                  right: 16,
                                  top: 16,
                                ),
                                child: isLoadingPage == true
                                    ? SizedBox()
                                    : Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    isLoadingPage == true
                                                        ? '-'
                                                        : '-',
                                                    // : '${selectedProperty != null ? translateKey.formatCurrency(selectedProperty?.price?.toDouble() ?? 0) : translateKey.formatCurrency(0)}',
                                                    // '₮${Utils().formatCurrencyCustom(data.price)}',
                                                    style: TextStyle(
                                                      color: primary,
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    translateKey.translate(
                                                      'per_day',
                                                    ),
                                                    style: TextStyle(
                                                      color: gray103,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: isLoadingPage == true
                                                    ? () {}
                                                    : selectedProperty == null
                                                    ? () {}
                                                    : () {},
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        tabIndex == 0 ||
                                                            selectedProperty ==
                                                                null
                                                        ? primary200
                                                        : primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 24,
                                                    vertical: 12,
                                                  ),
                                                  child: Text(
                                                    translateKey.translate(
                                                      'book_now',
                                                    ),
                                                    style: TextStyle(
                                                      color: white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
