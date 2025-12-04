// ignore_for_file: deprecated_member_use

import 'dart:async';
// import 'dart:io';
import 'dart:ui';
// import 'dart:ui' as ui;

import 'package:after_layout/after_layout.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:intl/intl.dart';
// import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/camp_data_edit.dart';
import 'package:merchant_gerbook_flutter/models/images.dart';
import 'package:merchant_gerbook_flutter/models/properties.dart';
import 'package:merchant_gerbook_flutter/src/tabs/ger_page/edit_camp_details/edit_camp_discount.dart';
import 'package:merchant_gerbook_flutter/src/tabs/ger_page/edit_camp_details/edit_camp_location.dart';
import 'package:merchant_gerbook_flutter/src/tabs/ger_page/edit_camp_details/edit_camp_name.dart';
import 'package:merchant_gerbook_flutter/src/tabs/ger_page/edit_camp_details/edit_camp_photo.dart';
import 'package:merchant_gerbook_flutter/src/tabs/ger_page/edit_camp_details/edit_camp_tags.dart';
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
  CampDataEdit data = CampDataEdit();
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
      backgroundColor: white,
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: gray200, width: 2)),
        toolbarHeight: 56,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/chevron_left.svg', height: 20),
            ],
          ),
        ),
        title: Text(
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
      body: isLoadingPage == true
          ? CustomLoader()
          : Stack(
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
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.3,
                                    child: BlurHash(
                                      color: gray100,
                                      hash: '${data.blurhash}',
                                      image: '${data.url}',
                                      imageFit: BoxFit.cover,
                                    ),
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,

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
                                        borderRadius: BorderRadius.circular(2),
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
                            top: 12,
                            right: 12,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(EditCampPhoto.routeName);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: black.withOpacity(0.8),
                                ),
                                padding: EdgeInsets.all(12),
                                child: SvgPicture.asset(
                                  'assets/svg/edit.svg',
                                  height: 20,
                                  width: 20,
                                  fit: BoxFit.cover,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                        ],
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
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
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
                                      borderRadius: BorderRadius.circular(12),
                                      color: tabIndex == 0 ? white : gray100,
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          translateKey.translate('only_detail'),
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
                                      borderRadius: BorderRadius.circular(12),
                                      color: tabIndex == 1 ? white : gray100,
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 8),
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
                                      SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            translateKey.translate(
                                              'description',
                                            ),
                                            style: TextStyle(
                                              color: blackText,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                EditCampName.routeName,
                                              );
                                            },
                                            child: SvgPicture.asset(
                                              'assets/svg/edit_ger_detail.svg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
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
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${translateKey.translate('address_title')}',
                                            style: TextStyle(
                                              color: blackText,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                EditCampLocation.routeName,
                                              );
                                            },
                                            child: SvgPicture.asset(
                                              'assets/svg/edit_ger_detail.svg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${translateKey.translate('additional_information')}',
                                            style: TextStyle(
                                              color: blackText,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                EditCampTags.routeName,
                                              );
                                            },
                                            child: SvgPicture.asset(
                                              'assets/svg/edit_ger_detail.svg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      data.placeOffers == null
                                          ? SizedBox()
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  translateKey.translate(
                                                    'place_offers',
                                                  ),
                                                  style: TextStyle(
                                                    color: gray700,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 6),
                                                Wrap(
                                                  spacing: 8,
                                                  runSpacing: 8,
                                                  children: [
                                                    if (data.placeOffers !=
                                                        null)
                                                      ...data.placeOffers!
                                                          .map(
                                                            (item) => Container(
                                                              width: 70,
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    height: 50,
                                                                    width: 50,
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                          12,
                                                                        ),
                                                                    decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      // color: gray101,
                                                                      border: Border.all(
                                                                        color:
                                                                            gray101,
                                                                      ),
                                                                    ),
                                                                    child: Center(
                                                                      child: Image.network(
                                                                        '${item.image!.url}',
                                                                        height:
                                                                            28,
                                                                        width:
                                                                            28,
                                                                        cacheWidth:
                                                                            28,
                                                                        cacheHeight:
                                                                            28,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    translateKey
                                                                        .translate(
                                                                          '${item.name}',
                                                                        ),
                                                                    // '${item.name}',
                                                                    style: TextStyle(
                                                                      color:
                                                                          black,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                      SizedBox(height: 16),
                                      data.tags == null
                                          ? SizedBox()
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  translateKey.translate(
                                                    'tags',
                                                  ),
                                                  style: TextStyle(
                                                    color: gray700,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 6),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      ...data.tags!
                                                          .map(
                                                            (item) => Row(
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          6,
                                                                        ),
                                                                    color:
                                                                        gray100,
                                                                    border: Border.all(
                                                                      color:
                                                                          gray100,
                                                                    ),
                                                                  ),
                                                                  padding:
                                                                      EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            6,
                                                                        vertical:
                                                                            2,
                                                                      ),
                                                                  child: Text(
                                                                    translateKey
                                                                        .translate(
                                                                          '${item.name}',
                                                                        ),
                                                                    // '${item.name}',
                                                                    style: TextStyle(
                                                                      color:
                                                                          black,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 6,
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                          .toList(),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                      SizedBox(height: 16),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          color: gray100,
                                          border: Border.all(color: gray100),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svg/check.svg',
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              data.isOpenYearRound == true
                                                  ? '${translateKey.translate('open_year_round')}'
                                                  : '${translateKey.translate('seasonal_operation')}',
                                              style: TextStyle(
                                                color:
                                                    data.isOpenYearRound == true
                                                    ? textBlue
                                                    : gray800,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        translateKey.translate('check_in_out'),
                                        style: TextStyle(
                                          color: gray700,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Container(
                                        width: MediaQuery.of(
                                          context,
                                        ).size.width,
                                        child: Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          alignment: WrapAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
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
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
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
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${translateKey.translate('additional_information')}',
                                            style: TextStyle(
                                              color: blackText,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                EditCampDiscount.routeName,
                                              );
                                            },
                                            child: SvgPicture.asset(
                                              'assets/svg/edit_ger_detail.svg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Text(
                                      //   translateKey.translate(
                                      //     'cancellation_policy',
                                      //   ),
                                      //   style: TextStyle(
                                      //     color: gray800,
                                      //     fontSize: 18,
                                      //     fontWeight: FontWeight.w600,
                                      //   ),
                                      // ),
                                      SizedBox(height: 12),
                                      data.cancelPolicies!.isEmpty == true
                                          ? Container(
                                              width: MediaQuery.of(
                                                context,
                                              ).size.width,
                                              padding: EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: gray200,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: white,
                                              ),
                                              child: Text(
                                                translateKey.translate(
                                                  'anytime_cancel',
                                                ),
                                                style: TextStyle(
                                                  color: primary,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : data.cancelPolicies!.every(
                                              (item) => item.rate == 0,
                                            )
                                          ? Container(
                                              width: MediaQuery.of(
                                                context,
                                              ).size.width,
                                              padding: EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: gray200,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: white,
                                              ),
                                              child: Text(
                                                translateKey.translate(
                                                  'no_refund',
                                                ),
                                                style: TextStyle(
                                                  color: blackText,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : data.cancelPolicies!.every(
                                              (item) => item.rate == 100,
                                            )
                                          ? Container(
                                              width: MediaQuery.of(
                                                context,
                                              ).size.width,
                                              padding: EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: gray200,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: white,
                                              ),
                                              child: Text(
                                                translateKey.translate(
                                                  'anytime_cancel',
                                                ),
                                                style: TextStyle(
                                                  color: blackText,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: data.cancelPolicies!
                                                      .map(
                                                        (item) => Column(
                                                          children: [
                                                            Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                    context,
                                                                  ).size.width,
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        10,
                                                                  ),
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      8,
                                                                    ),
                                                                color: white,
                                                                border:
                                                                    Border.all(
                                                                      color:
                                                                          gray200,
                                                                    ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          '${translateKey.translate('${item.cancelPolicy?.name}')}',
                                                                          style: TextStyle(
                                                                            color:
                                                                                gray800,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              6,
                                                                        ),
                                                                        Text(
                                                                          item.cancelPolicy?.start ==
                                                                                  0
                                                                              ? '${translateKey.translate('24 цагийн өмнө цуцлах бол_description')}'
                                                                              : item.cancelPolicy?.start ==
                                                                                    2
                                                                              ? '${translateKey.translate('2 - 7 хоногийн өмнө цуцлах бол_description')}'
                                                                              : item.cancelPolicy?.start ==
                                                                                    8
                                                                              ? '${translateKey.translate('8 - 14 хоногийн өмнө цуцлах бол_description')}'
                                                                              : '${translateKey.translate('15-аас дээш хоногийн өмнө цуцлах бол_description')}',
                                                                          style: TextStyle(
                                                                            color:
                                                                                gray600,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    '${item.rate}%',
                                                                    style: TextStyle(
                                                                      color:
                                                                          item.rate ==
                                                                              100
                                                                          ? primary
                                                                          : warningColor,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                      .toList(),
                                                ),
                                              ],
                                            ),
                                      data.travelOffers!.isEmpty == true
                                          ? SizedBox()
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  translateKey.translate(
                                                    'additional_services',
                                                  ),
                                                  style: TextStyle(
                                                    color: gray700,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                    color: white,
                                                    border: Border.all(
                                                      color: gray200,
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.all(12),
                                                  child: Wrap(
                                                    runSpacing: 12,
                                                    children: data.travelOffers!
                                                        .map(
                                                          (data) => Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              SvgPicture.asset(
                                                                'assets/svg/check.svg',
                                                              ),
                                                              Text(
                                                                // local.translate('guests'),
                                                                '${data.travelOffer?.name ?? ''}',
                                                                style: TextStyle(
                                                                  color:
                                                                      gray104,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                                ),
                                              ],
                                            ),

                                      // data.discount != null &&
                                      //         data.discount != 0
                                      //     ? Column(
                                      //         children: [
                                      //           SizedBox(height: 12),
                                      //           Container(
                                      //             height: 1,
                                      //             width: MediaQuery.of(
                                      //               context,
                                      //             ).size.width,
                                      //             color: Black08,
                                      //           ),
                                      //           SizedBox(height: 12),
                                      //           Column(
                                      //             crossAxisAlignment:
                                      //                 CrossAxisAlignment.start,
                                      //             children: [
                                      //               Text(
                                      //                 translateKey.translate(
                                      //                   'discounts',
                                      //                 ),
                                      //                 style: TextStyle(
                                      //                   color: blackText,
                                      //                   fontSize: 14,
                                      //                   fontWeight:
                                      //                       FontWeight.w700,
                                      //                 ),
                                      //               ),
                                      //               SizedBox(height: 8),
                                      //               Row(
                                      //                 mainAxisAlignment:
                                      //                     MainAxisAlignment
                                      //                         .spaceBetween,
                                      //                 children: [
                                      //                   Text(
                                      //                     '${data.discount.discountObj!.discountType!.value} ${translateKey.translate('or_more_nights_of_booking')} ${data.disctount.discountObj!.rate}%',
                                      //                     style: TextStyle(
                                      //                       color: blackText,
                                      //                       fontSize: 14,
                                      //                       fontWeight:
                                      //                           FontWeight.w500,
                                      //                     ),
                                      //                   ),
                                      //                   Text(
                                      //                     '${translateKey
                                      //                         .formatCurrency(
                                      //                           bookingData
                                      //                               .discount!
                                      //                               .toDouble(),
                                      //                         ),}',
                                      //                     style: TextStyle(
                                      //                       color: verifyGreen,
                                      //                       fontSize: 14,
                                      //                       fontWeight:
                                      //                           FontWeight.w500,
                                      //                     ),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ],
                                      //       )
                                      //     : SizedBox(),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                fontWeight: FontWeight.w600,
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
                                                          width: mediaQuery
                                                              .size
                                                              .width,
                                                          height: 210,
                                                          child: BlurHash(
                                                            color: gray100,
                                                            hash:
                                                                '${item.mainImage!.blurhash}',
                                                            image:
                                                                '${item.mainImage!.url}',
                                                            imageFit:
                                                                BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.all(
                                                          6,
                                                        ),
                                                        child: Text(
                                                          '${item.name!}',
                                                          style: TextStyle(
                                                            color: black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 2),
                                                      Row(
                                                        children: [
                                                          SizedBox(width: 6),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    8,
                                                                  ),
                                                              color: white,
                                                              border:
                                                                  Border.all(
                                                                    color:
                                                                        gray200,
                                                                  ),
                                                            ),
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 6,
                                                                ),
                                                            child: Row(
                                                              children: [
                                                                // SvgPicture.asset(
                                                                //   'assets/svg/bed_icon.svg',
                                                                // ),
                                                                SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Text(
                                                                  '${item.bedsCount ?? '-'} ${translateKey.translate('beds')}',
                                                                  style: TextStyle(
                                                                    color:
                                                                        black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    8,
                                                                  ),
                                                              color: white,
                                                              border:
                                                                  Border.all(
                                                                    color:
                                                                        gray200,
                                                                  ),
                                                            ),
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 6,
                                                                ),
                                                            child: Row(
                                                              children: [
                                                                // SvgPicture.asset(
                                                                //   'assets/svg/person_icon.svg',
                                                                // ),
                                                                SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Text(
                                                                  '${item.maxPersonCount ?? '-'} ${translateKey.translate('person')}',
                                                                  style: TextStyle(
                                                                    color:
                                                                        black,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 2),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                // setState(() {
                                                                //   if (selectedProperty ==
                                                                //       item) {
                                                                //     selectedProperty =
                                                                //         null;
                                                                //   } else {
                                                                //     selectedProperty =
                                                                //         item;
                                                                //   }
                                                                // });
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
                                                                      '${translateKey.translate('calendar')}',
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
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          // SizedBox(width: 6),
                                                          Expanded(
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                // setState(() {
                                                                //   if (selectedProperty ==
                                                                //       item) {
                                                                //     selectedProperty =
                                                                //         null;
                                                                //   } else {
                                                                //     selectedProperty =
                                                                //         item;
                                                                //   }
                                                                // });
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
                                                                      '${translateKey.translate('zasah')}',
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
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 12),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                  SizedBox(
                                    height: mediaQuery.padding.bottom + 100,
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
                // tabIndex == 0
                //     ? SizedBox()
                //     : Align(
                //         alignment: Alignment.bottomCenter,
                //         child: Container(
                //           width: MediaQuery.of(context).size.width,
                //           decoration: BoxDecoration(
                //             color: white,
                //             boxShadow: [
                //               BoxShadow(
                //                 color: Black10,
                //                 blurRadius: 12,
                //                 offset: ui.Offset(0, -1),
                //               ),
                //             ],
                //           ),
                //           padding: EdgeInsets.only(
                //             bottom: Platform.isIOS
                //                 ? MediaQuery.of(context).padding.bottom
                //                 : 16,
                //             left: 16,
                //             right: 16,
                //             top: 16,
                //           ),
                //           child: isLoadingPage == true
                //               ? SizedBox()
                //               : Column(
                //                   mainAxisSize: MainAxisSize.min,
                //                   children: [
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Column(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.center,
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             Text(
                //                               isLoadingPage == true
                //                                   ? '-'
                //                                   : '-',
                //                               // : '${selectedProperty != null ? translateKey.formatCurrency(selectedProperty?.price?.toDouble() ?? 0) : translateKey.formatCurrency(0)}',
                //                               // '₮${Utils().formatCurrencyCustom(data.price)}',
                //                               style: TextStyle(
                //                                 color: primary,
                //                                 fontSize: 24,
                //                                 fontWeight:
                //                                     FontWeight.w600,
                //                               ),
                //                             ),
                //                             Text(
                //                               translateKey.translate(
                //                                 'per_day',
                //                               ),
                //                               style: TextStyle(
                //                                 color: gray103,
                //                                 fontSize: 12,
                //                                 fontWeight:
                //                                     FontWeight.w400,
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                         GestureDetector(
                //                           onTap: isLoadingPage == true
                //                               ? () {}
                //                               : selectedProperty == null
                //                               ? () {}
                //                               : () {},
                //                           child: Container(
                //                             decoration: BoxDecoration(
                //                               color:
                //                                   tabIndex == 0 ||
                //                                       selectedProperty ==
                //                                           null
                //                                   ? primary200
                //                                   : primary,
                //                               borderRadius:
                //                                   BorderRadius.circular(
                //                                     8,
                //                                   ),
                //                             ),
                //                             padding: EdgeInsets.symmetric(
                //                               horizontal: 24,
                //                               vertical: 12,
                //                             ),
                //                             child: Text(
                //                               translateKey.translate(
                //                                 'book_now',
                //                               ),
                //                               style: TextStyle(
                //                                 color: white,
                //                                 fontSize: 14,
                //                                 fontWeight:
                //                                     FontWeight.w500,
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //         ),
                //       ),
              ],
            ),
    );
  }
}
