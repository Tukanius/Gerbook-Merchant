// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:after_layout/after_layout.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/camp_create_model.dart';
import 'package:merchant_gerbook_flutter/models/cancel_policy.dart';
import 'package:merchant_gerbook_flutter/models/create_camp_property.dart';
import 'package:merchant_gerbook_flutter/models/discount_types.dart';
import 'package:merchant_gerbook_flutter/models/travel_offers.dart';
import 'package:merchant_gerbook_flutter/models/upload_image.dart';
import 'package:merchant_gerbook_flutter/provider/camp_create_provider.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/create_ger_comps/create_ger_pages.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/tools/edit_ger.dart';
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
  int _currentIndex = 0;
  bool isLoadingButton = false;

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
    print('====test====');
    print(allImages.length);
    print('====test====');
  }

  onSubmit() async {
    final translateKey = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    );

    final createCampRoot = Provider.of<CampCreateProvider>(
      context,
      listen: false,
    );
    if (createCampRoot.gerName != '') {
      try {
        CampCreateModel campData = CampCreateModel();
        setState(() {
          isLoadingButton = true;
        });

        campData.name = createCampRoot.name;

        campData.description = createCampRoot.description;

        campData.longitude = num.parse(createCampRoot.longitude);
        campData.latitude = num.parse(createCampRoot.latitude);
        campData.level0 = createCampRoot.level0;
        campData.level1 = createCampRoot.level1;
        if (createCampRoot.level2 != '') {
          campData.level2 = createCampRoot.level2;
        }
        if (createCampRoot.level3 != '') {
          campData.level3 = createCampRoot.level3;
        }
        campData.additionalInformation = createCampRoot.addressDetail;
        campData.checkInTime = createCampRoot.checkInTime;
        campData.checkOutTime = createCampRoot.checkOutTime;

        campData.isOpenYearRound = createCampRoot.fourSeason;
        campData.zone = createCampRoot.zoneId != ''
            ? createCampRoot.zoneId
            : null;

        campData.tags = createCampRoot.tags
            .map((tagObject) => tagObject.id)
            .cast<String>()
            .toList();

        campData.placeOffers = createCampRoot.placeOffers
            .map((tagObject) => tagObject.id)
            .cast<String>()
            .toList();

        // campData.tags = createCampRoot.tags;
        // campData.placeOffers = createCampRoot.placeOffers;
        // campData.discounts = createCampRoot.discount
        //     .map((d) {
        //       return {
        //         "discountType": d.id,
        //         "rate": d.procent.toString(), // эсвэл d.rate
        //       };
        //     })
        //     .cast<DiscountTypes>()
        //     .toList();
        campData.discounts = createCampRoot.discount.map((d) {
          return DiscountTypes(discountType: d.id, rate: d.procent);
        }).toList();

        // campData.discounts = createCampRoot.discount;
        // campData.cancelPolicies = createCampRoot.cancelPolicy
        //     .map((d) {
        //       return {
        //         "discountType": d.id,
        //         "rate": d.rate.toString(), // эсвэл d.rate
        //       };
        //     })
        //     .cast<CancelPolicy>()
        //     .toList();
        campData.cancelPolicies = createCampRoot.cancelPolicy.map((d) {
          return CancelPolicy(cancelPolicy: d.id, rate: d.rate);
        }).toList();

        // campData.cancelPolicies = createCampRoot.cancelPolicy;
        campData.images = createCampRoot.images
            .map((tagObject) => tagObject.url)
            .cast<String>()
            .toList();

        // campData.images = createCampRoot.images;
        campData.mainImage = createCampRoot.mainImage.url;
        // campData.mainImage = createCampRoot.mainImage;
        // campData.travelOffers = createCampRoot.travelOffers
        //     .map((d) {
        //       return {
        //         "travelOffer": d.id,
        //         "price": d.price,
        //         "maxQuantity": d.maxQuantity,
        //       };
        //     })
        //     .cast<TravelOffers>()
        //     .toList();
        campData.travelOffers = createCampRoot.travelOffers.map((d) {
          return TravelOffers(
            travelOffer: d.id,
            price: d.price,
            maxQuantity: d.maxQuantity,
          );
        }).toList();
        print('========ibj=-====');
        print(isLoadingButton);
        print(campData.travelOffers);
        print('=data==');
        print(
          createCampRoot.travelOffers.map((d) {
            return TravelOffers(
              travelOffer: d.id,
              price: d.price,
              maxQuantity: d.maxQuantity,
            );
          }).toList(),
        );
        print('========ibj=-====');

        // campData.travelOffers = createCampRoot.travelOffers;

        campData.properties = [
          CreateCampProperty(
            name: createCampRoot.gerName,
            description: createCampRoot.gerDescription,
            images: createCampRoot.gerImages
                .map((tagObject) => tagObject.url)
                .cast<String>()
                .toList(),
            mainImage: createCampRoot.gerMainImage.url,
            bedsCount: int.tryParse(createCampRoot.gerBedCount),
            price: createCampRoot.gerPrice,
            originalPrice: createCampRoot.gerPrice,
            maxPersonCount: int.tryParse(createCampRoot.gerMaxPerson),
            quantity: int.tryParse(createCampRoot.gerQuantity),
          ),
        ];

        await ProductApi().createCampApi(campData);
        await showCreateSuccess(
          context,
          '${translateKey.translate('listing_created_successfully')}',
        );
        setState(() {
          isLoadingButton = false;
        });
      } catch (e) {
        setState(() {
          isLoadingButton = false;
        });
      }
    }
  }

  showCreateSuccess(context, String text) async {
    final local = Provider.of<LocalizationProvider>(context, listen: false);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SvgPicture.asset('assets/svg/success1.svg'),
                Text(
                  local.translate('successful'),
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '$text',
                  style: TextStyle(
                    color: gray600,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
                ButtonBar(
                  buttonMinWidth: 100,
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                      ),
                      child: Text(
                        local.translate('close'),
                        style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String timeOfDayToIso(TimeOfDay tod) {
    final now = DateTime.now(); // Өнөөдрийн огноо
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    return dt.toUtc().toIso8601String();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);
    final campProvider = Provider.of<CampCreateProvider>(context, listen: true);
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
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CarouselSlider(
                                  carouselController: carouselController,
                                  items: allImages.map((data) {
                                    return Container(
                                      width: mediaQuery.size.width,
                                      height: 245,
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
                                    height: 245,
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
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
                                            borderRadius: BorderRadius.circular(
                                              2,
                                            ),
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
                            ],
                          ),
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
                          campProvider.gerName == ''
                              ? Container(
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
                                                translateKey.translate(
                                                  'no_ger',
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
                                              Navigator.of(context).pushNamed(
                                                CreateGerPages.routeName,
                                                arguments:
                                                    CreateGerPagesArguments(
                                                      campUpdate: false,
                                                      campId: '',
                                                    ),
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: white,
                                                border: Border.all(
                                                  color: gray300,
                                                ),
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
                                )
                              : Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: SizedBox(
                                        height: 72,
                                        width: 72,
                                        child: BlurHash(
                                          color: gray100,
                                          hash:
                                              '${campProvider.gerMainImage.blurhash}',
                                          image:
                                              '${campProvider.gerMainImage.url}',
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
                                            '${campProvider.gerName}',
                                            style: TextStyle(
                                              color: gray900,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 2),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/ger_bed.svg',
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                '${campProvider.gerBedCount}',
                                                style: TextStyle(
                                                  color: gray600,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(width: 12),
                                              SvgPicture.asset(
                                                'assets/svg/ger_person.svg',
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                '${campProvider.gerMaxPerson}',
                                                style: TextStyle(
                                                  color: gray600,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            '₮${campProvider.gerOriginalPrice}',
                                            style: TextStyle(
                                              color: primary,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16),
                                              topRight: Radius.circular(16),
                                            ),
                                          ),
                                          isDismissible: true,
                                          backgroundColor: transparent,
                                          builder: (context) {
                                            return EditGer();
                                          },
                                        );
                                      },
                                      child: SvgPicture.asset(
                                        'assets/svg/more_edit.svg',
                                      ),
                                    ),
                                    // Image.network(
                                    //   '${campProvider.gerMainImage.url}',
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ],
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
                                  onTap: isLoadingButton == true
                                      ? () {}
                                      : () {
                                          onSubmit();
                                        },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: campProvider.gerName == ''
                                          ? primary200
                                          : primary,
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
                                        isLoadingButton == true
                                            ? CustomLoader(loadColor: white)
                                            : Text(
                                                translateKey.translate(
                                                  'continue',
                                                ),
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
