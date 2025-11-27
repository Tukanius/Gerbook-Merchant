import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/images.dart';
import 'package:merchant_gerbook_flutter/models/upload_image.dart';
import 'package:merchant_gerbook_flutter/provider/camp_create_provider.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/create_ger_comps/create_ger_pages.dart';
import 'package:provider/provider.dart';

class CreateCampConfirm extends StatefulWidget {
  final PageController pageController;

  const CreateCampConfirm({super.key, required this.pageController});

  @override
  State<CreateCampConfirm> createState() => _CreateCampConfirmState();
}

class _CreateCampConfirmState extends State<CreateCampConfirm>
    with AfterLayoutMixin {
  CarouselSliderController carouselController = CarouselSliderController();
  final List<UploadImage> allImages = [];

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final campProvider = Provider.of<CampCreateProvider>(
      context,
      listen: false,
    );
    final uniqueUrls = <String>{};

    if (campProvider.mainImage != []) {
      if (uniqueUrls.add(campProvider.mainImage.url!)) {
        setState(() {
          allImages.add(campProvider.mainImage);
        });
      }
    }

    for (final image in campProvider.images) {
      if (image.url != null && uniqueUrls.add(image.url!)) {
        setState(() {
          allImages.add(image);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);
    final campProvider = Provider.of<CampCreateProvider>(context);
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(
      context,
    );
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: white,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: gray100)),
                  ),
                  padding: EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translateKey.translate('confirm'),
                              style: TextStyle(
                                color: gray800,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '${translateKey.translate('please_confirm_entered_info')}',
                              style: TextStyle(
                                color: gray600,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: white,
                          border: Border.all(color: gray300),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '6/6',
                          style: TextStyle(
                            color: gray800,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(12),
                            child: SizedBox(
                              width: mediaQuery.size.width,
                              height: 245,
                              child: BlurHash(
                                color: gray100,
                                hash: '${campProvider.mainImage.blurhash}',
                                image: '${campProvider.mainImage.url}',
                                imageFit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // ClipRRect(
                          //   borderRadius: BorderRadiusGeometry.circular(12),
                          //   child: Container(
                          //     width: mediaQuery.size.width,
                          //     height: 245,
                          //     child: Image.asset(
                          //       'assets/images/zurag.png',
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          // ClipRRect(
                          //   borderRadius: BorderRadius.only(
                          //     bottomLeft: Radius.circular(24),
                          //     bottomRight: Radius.circular(24),
                          //   ),
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       // Navigator.of(context).pushNamed(
                          //       //   FullScreenImage.routeName,
                          //       //   arguments: FullScreenImageArguments(
                          //       //     images: data.images!,
                          //       //   ),
                          //       // );
                          //     },
                          //     child: CarouselSlider(
                          //       carouselController: carouselController,
                          //       items: allImages.map((data) {
                          //         return Container(
                          //           width: MediaQuery.of(context).size.width,
                          //           height: MediaQuery.of(context).size.height *
                          //               0.45,
                          //           child: BlurHash(
                          //             color: gray100,
                          //             hash: '${data.blurhash}',
                          //             image: '${data.url}',
                          //             imageFit: BoxFit.cover,
                          //           ),
                          //         );
                          //         // Container(
                          //         //   width: MediaQuery.of(context).size.width,
                          //         //   height: MediaQuery.of(context).size.height * 0.45,
                          //         //   decoration: BoxDecoration(
                          //         //     image: DecorationImage(
                          //         //       image: NetworkImage(data.url!),
                          //         //       fit: BoxFit.cover,
                          //         //     ),
                          //         //   ),
                          //         //   // child: Container(
                          //         //   //   color: Colors.transparent,
                          //         //   // ),
                          //         // );
                          //       }).toList(),
                          //       options: CarouselOptions(
                          //         height:
                          //             MediaQuery.of(context).size.height * 0.45,
                          //         // enlargeCenterPage: true,
                          //         // autoPlay: true,
                          //         // aspectRatio: 16 / 9,
                          //         viewportFraction: 1,
                          //         onPageChanged: (index, reason) {
                          //           setState(() {
                          //             _currentIndex = index;
                          //           });
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: 16),
                          Text(
                            campProvider.name,
                            style: TextStyle(
                              color: gray800,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: campProvider.tags
                                .map(
                                  (item) => GestureDetector(
                                    onTap: () {
                                      // setState(() {
                                      //   if (isSelected) {
                                      //     filterTag.remove(item.id);
                                      //     filterTagName.remove(item.name!);
                                      //   } else {
                                      //     filterTag.add(item.id!);
                                      //     filterTagName.add(item.name!);
                                      //   }
                                      // });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        // border: Border.all(
                                        //   color: isSelected ? primary : gray200,
                                        // ),
                                        color: pinColor,
                                        // color: isSelected ? primary : white,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // isSelected
                                          //     ? Image.network(
                                          //         height: 20,
                                          //         width: 20,
                                          //         'assets/images/zurag.png',
                                          //         fit: BoxFit.contain,
                                          //       )
                                          //     : Image.network(
                                          //         height: 20,
                                          //         width: 20,
                                          //         'assets/images/zurag.png',
                                          //         fit: BoxFit.contain,
                                          //       ),
                                          Text(
                                            translateKey.translate(
                                              '${item.name}',
                                            ),
                                            style: TextStyle(
                                              color: gray800,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(height: 16),
                          Text(
                            translateKey.translate('description'),
                            style: TextStyle(
                              color: gray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            campProvider.description,
                            style: TextStyle(
                              color: gray400,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translateKey.translate('place_offers'),
                                style: TextStyle(
                                  color: gray700,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 6),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: campProvider.placeOffers
                                    .map(
                                      (item) => Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: pinColor,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.network(
                                              '${item.image?.url}',
                                              height: 20,
                                              width: 20,
                                              fit: BoxFit.cover,
                                            ),

                                            SizedBox(width: 8),
                                            Text(
                                              translateKey.translate(
                                                '${item.name}',
                                              ),
                                              style: TextStyle(
                                                color: gray800,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                                //  placeOffers.rows!.map((item) {
                                //   bool isSelected = filterOffer.contains(
                                //     item.id,
                                //   );
                                //   return GestureDetector(
                                //     onTap: () {
                                //       setState(() {
                                //         if (isSelected) {
                                //           filterOffer.remove(item.id);
                                //           filterOfferName.remove(item.name);
                                //         } else {
                                //           filterOffer.add(item.id!);
                                //           filterOfferName.add(item.name!);
                                //         }
                                //       });
                                //     },
                                //     child: Container(
                                //       padding: EdgeInsets.symmetric(
                                //         horizontal: 12,
                                //         vertical: 6,
                                //       ),
                                //       decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(
                                //           100,
                                //         ),
                                //         border: Border.all(
                                //           color: isSelected ? primary : gray200,
                                //         ),
                                //         color: isSelected ? primary : white,
                                //       ),
                                //       child: Row(
                                //         mainAxisSize: MainAxisSize.min,
                                //         children: [
                                //           Image.network(
                                //             height: 22,
                                //             width: 22,
                                //             '${item.image!.url}',
                                //             fit: BoxFit.contain,
                                //           ),
                                //           SizedBox(width: 8),
                                //           Text(
                                //             translateKey.translate(
                                //               '${item.name}',
                                //             ),
                                //             // '${item.name}',
                                //             style: TextStyle(
                                //               color: isSelected
                                //                   ? white
                                //                   : gray800,
                                //               fontSize: 14,
                                //               fontWeight: FontWeight.w400,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   );
                                // }).toList(),
                              ),
                            ],
                          ),
                          // SizedBox(height: 16),
                          // Text(
                          //   '${translateKey.translate('bed_numbers')}:',
                          //   style: TextStyle(
                          //     color: gray900,
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // ),
                          // SizedBox(height: 4),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Text(
                          //         '2 ${translateKey.translate('beds')}',
                          //         style: TextStyle(
                          //           color: gray600,
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w400,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(height: 16),
                          // Container(
                          //   width: mediaQuery.size.width,
                          //   height: 1,
                          //   color: gray200,
                          // ),
                          SizedBox(height: 16),
                          Text(
                            '${translateKey.translate('address_title')}:',
                            style: TextStyle(
                              color: gray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${campProvider.addressDetail}',
                                  style: TextStyle(
                                    color: gray600,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: mediaQuery.size.width,
                            height: 1,
                            color: gray200,
                          ),
                          SizedBox(height: 16),
                          Text(
                            '${translateKey.translate('ger')}',
                            style: TextStyle(
                              color: gray800,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: primaryRange,
                              border: Border.all(color: gray200),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: 32),
                                    SvgPicture.asset(
                                      'assets/svg/empty_box.svg',
                                      width: 141,
                                    ),
                                    SizedBox(height: 12),
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
                                          translateKey.translate(
                                            'required_one_ger',
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
                                    SizedBox(height: 12),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(
                                          context,
                                        ).pushNamed(CreateGerPages.routeName);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: white,
                                          border: Border.all(color: gray300),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 16,
                                        ),
                                        child: Text(
                                          '${translateKey.translate('create_listing')}',
                                          style: TextStyle(
                                            color: gray700,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 32),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: mediaQuery.padding.bottom + 150),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            !isKeyboardVisible
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: gray300)),
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
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    widget.pageController.previousPage(
                                      duration: Duration(microseconds: 1000),
                                      curve: Curves.ease,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: white,
                                      border: Border.all(color: gray300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          translateKey.translate(
                                            'navigation_back',
                                          ),
                                          style: TextStyle(
                                            color: gray700,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    widget.pageController.nextPage(
                                      duration: Duration(microseconds: 1000),
                                      curve: Curves.ease,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          translateKey.translate('continue'),
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
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
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
