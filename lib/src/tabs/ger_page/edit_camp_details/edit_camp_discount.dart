// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/cancel_policy.dart';
import 'package:merchant_gerbook_flutter/models/discount_types.dart';
import 'package:merchant_gerbook_flutter/models/result.dart';
import 'package:merchant_gerbook_flutter/models/travel_offers.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/tools/add_cancel_policy.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/tools/add_discount.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/tools/add_service.dart';
import 'package:provider/provider.dart';

class EditCampDiscount extends StatefulWidget {
  static const routeName = "EditCampDiscount";
  const EditCampDiscount({super.key});

  @override
  State<EditCampDiscount> createState() => _EditCampDiscountState();
}

class _EditCampDiscountState extends State<EditCampDiscount>
    with AfterLayoutMixin {
  int page = 1;
  int limit = 30;
  bool isLoadingPage = true;
  Result travelOffers = Result();
  Result cancelPolicy = Result();
  Result discounts = Result();

  List<TravelOffers> selectedServices = [];
  List<DiscountTypes> selectedDiscount = [];
  List<CancelPolicy> selectedCancelPolicy = [];

  List<TextEditingController> discontController = [];

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  bool isLoadingButton = false;

  onSubmit() async {
    // try {
    //   setState(() {
    //     isLoadingButton = true;
    //   });
    //   print(isLoadingButton);
    //   print('=====am in ?? =====');
    //   await Provider.of<CampCreateProvider>(
    //     context,
    //     listen: false,
    //   ).updateTravelOffers(newTravelOffers: selectedServices);

    //   await Provider.of<CampCreateProvider>(
    //     context,
    //     listen: false,
    //   ).updateDiscounts(newDiscounts: selectedDiscount);
    //   await Provider.of<CampCreateProvider>(
    //     context,
    //     listen: false,
    //   ).updateCancelPolicy(newCancelPolicy: selectedCancelPolicy);

    //   // widget.pageController.nextPage(
    //   //   duration: Duration(microseconds: 1000),
    //   //   curve: Curves.ease,
    //   // );
    //   setState(() {
    //     isLoadingButton = false;
    //   });
    // } catch (e) {
    //   setState(() {
    //     isLoadingButton = false;
    //   });
    // }
  }
  onSubmitConfirm() async {
    // final translateKey = Provider.of<LocalizationProvider>(
    //   context,
    //   listen: false,
    // );

    // try {
    //   final createCampRoot = Provider.of<CampCreateProvider>(
    //     context,
    //     listen: false,
    //   );
    //   CampCreateModel campData = CampCreateModel();
    //   setState(() {
    //     isLoadingButton = true;
    //   });

    //   campData.name = createCampRoot.name;

    //   campData.description = createCampRoot.description;

    //   campData.longitude = num.parse(createCampRoot.longitude);
    //   campData.latitude = num.parse(createCampRoot.latitude);
    //   campData.level0 = createCampRoot.level0;
    //   campData.level1 = createCampRoot.level1;
    //   if (createCampRoot.level2 != '') {
    //     campData.level2 = createCampRoot.level2;
    //   }
    //   if (createCampRoot.level3 != '') {
    //     campData.level3 = createCampRoot.level3;
    //   }
    //   campData.additionalInformation = createCampRoot.addressDetail;
    //   campData.checkInTime = createCampRoot.checkInTime;
    //   campData.checkOutTime = createCampRoot.checkOutTime;

    //   campData.isOpenYearRound = createCampRoot.fourSeason;
    //   campData.zone = createCampRoot.zoneId;

    //   campData.tags = createCampRoot.tags
    //       .map((tagObject) => tagObject.id)
    //       .cast<String>()
    //       .toList();

    //   campData.placeOffers = createCampRoot.placeOffers
    //       .map((tagObject) => tagObject.id)
    //       .cast<String>()
    //       .toList();

    //   // campData.tags = createCampRoot.tags;
    //   // campData.placeOffers = createCampRoot.placeOffers;
    //   // campData.discounts = createCampRoot.discount
    //   //     .map((d) {
    //   //       return {
    //   //         "discountType": d.id,
    //   //         "rate": d.procent.toString(), // эсвэл d.rate
    //   //       };
    //   //     })
    //   //     .cast<DiscountTypes>()
    //   //     .toList();
    //   campData.discounts = createCampRoot.discount.map((d) {
    //     return DiscountTypes(discountType: d.id, rate: d.procent);
    //   }).toList();

    //   // campData.discounts = createCampRoot.discount;
    //   // campData.cancelPolicies = createCampRoot.cancelPolicy
    //   //     .map((d) {
    //   //       return {
    //   //         "discountType": d.id,
    //   //         "rate": d.rate.toString(), // эсвэл d.rate
    //   //       };
    //   //     })
    //   //     .cast<CancelPolicy>()
    //   //     .toList();
    //   campData.cancelPolicies = createCampRoot.cancelPolicy.map((d) {
    //     return CancelPolicy(cancelPolicy: d.id, rate: d.rate);
    //   }).toList();

    //   // campData.cancelPolicies = createCampRoot.cancelPolicy;
    //   campData.images = createCampRoot.images
    //       .map((tagObject) => tagObject.url)
    //       .cast<String>()
    //       .toList();

    //   // campData.images = createCampRoot.images;
    //   campData.mainImage = createCampRoot.mainImage.url;
    //   // campData.mainImage = createCampRoot.mainImage;
    //   // campData.travelOffers = createCampRoot.travelOffers
    //   //     .map((d) {
    //   //       return {
    //   //         "travelOffer": d.id,
    //   //         "price": d.price,
    //   //         "maxQuantity": d.maxQuantity,
    //   //       };
    //   //     })
    //   //     .cast<TravelOffers>()
    //   //     .toList();
    //   campData.travelOffers = createCampRoot.travelOffers.map((d) {
    //     return TravelOffers(
    //       travelOffer: d.id,
    //       price: d.price,
    //       maxQuantity: d.maxQuantity,
    //     );
    //   }).toList();
    //   print('========ibj=-====');
    //   print(isLoadingButton);
    //   print(campData.travelOffers);
    //   print('=data==');
    //   print(
    //     createCampRoot.travelOffers.map((d) {
    //       return TravelOffers(
    //         travelOffer: d.id,
    //         price: d.price,
    //         maxQuantity: d.maxQuantity,
    //       );
    //     }).toList(),
    //   );
    //   print('========ibj=-====');

    //   // campData.travelOffers = createCampRoot.travelOffers;

    //   // campData.properties = [
    //   //   CreateCampProperty(
    //   //     name: createCampRoot.gerName,
    //   //     description: createCampRoot.gerDescription,
    //   //     images: createCampRoot.gerImages
    //   //         .map((tagObject) => tagObject.url)
    //   //         .cast<String>()
    //   //         .toList(),
    //   //     mainImage: createCampRoot.gerMainImage.url,
    //   //     bedsCount: int.tryParse(createCampRoot.gerBedCount),
    //   //     price: num.tryParse(createCampRoot.gerPrice),
    //   //     originalPrice: num.tryParse(createCampRoot.gerOriginalPrice),
    //   //     maxPersonCount: int.tryParse(createCampRoot.gerMaxPerson),
    //   //     quantity: int.tryParse(createCampRoot.gerQuantity),
    //   //   ),
    //   // ];

    //   // await ProductApi().updateCampApi(campData);
    //   // await showCreateSuccess(
    //   //   context,
    //   //   '${translateKey.translate('listing_created_successfully')}',
    //   // );
    //   setState(() {
    //     isLoadingButton = false;
    //   });
    // } catch (e) {
    //   setState(() {
    //     isLoadingButton = false;
    //   });
    // }
  }

  // build функц дотор:
  bool get allRatesAreZero =>
      selectedCancelPolicy.isNotEmpty &&
      selectedCancelPolicy.every((service) => service.rate == 0);

  void syncControllers() {
    discontController = selectedDiscount.map((e) {
      return TextEditingController(text: (e.procent ?? 0).toString());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(
      context,
    );
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SvgPicture.asset('assets/svg/chevron_left.svg')],
            ),
          ),
          centerTitle: false,
          title: Text(
            translateKey.translate('edit_camp'),
            style: TextStyle(
              color: gray800,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: isLoadingPage == true
            ? CustomLoader()
            : Stack(
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
                                    translateKey.translate(
                                      'additional_information',
                                    ),
                                    style: TextStyle(
                                      color: gray800,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '${translateKey.translate('ta_uuriyn_medeelliyg_65b43f00')}',
                                    style: TextStyle(
                                      color: gray600,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
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
                                SizedBox(height: 16),
                                Text(
                                  translateKey.translate('additional_services'),
                                  style: TextStyle(
                                    color: gray800,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 14),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: white,
                                    border: Border.all(color: gray300),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      selectedServices.isEmpty == true
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 4),

                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 12,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                    color: gray50,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        '${translateKey.translate('no_additional_services')}',
                                                        style: TextStyle(
                                                          color: gray400,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: selectedServices.map((
                                                service,
                                              ) {
                                                // Initialize defaults if null (Optional logic)
                                                // service.quantity = service.quantity ?? 1;
                                                // service.price = service.price ?? 0;

                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: 10,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              service.name ??
                                                                  '',
                                                              style: TextStyle(
                                                                color: gray700,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 6),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              height: 36,

                                                              decoration: BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                      color:
                                                                          gray300,
                                                                    ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      8,
                                                                    ),
                                                              ),
                                                              child: TextField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration: InputDecoration(
                                                                  isDense: true,
                                                                  suffix: Text(
                                                                    '${translateKey.translate('price')}',
                                                                    style: TextStyle(
                                                                      color:
                                                                          gray700,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      '0₮',
                                                                  contentPadding:
                                                                      EdgeInsets.all(
                                                                        8,
                                                                      ),
                                                                ),
                                                                onChanged: (value) {
                                                                  // Save quantity to your model
                                                                  service.maxQuantity =
                                                                      int.tryParse(
                                                                        value,
                                                                      );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 6),

                                                          Expanded(
                                                            child: Container(
                                                              height: 36,

                                                              decoration: BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                      color:
                                                                          gray300,
                                                                    ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      8,
                                                                    ),
                                                              ),
                                                              child: TextField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration: InputDecoration(
                                                                  isDense: true,
                                                                  suffix: Text(
                                                                    'Ш',
                                                                    style: TextStyle(
                                                                      color:
                                                                          gray700,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      '0ш',
                                                                  contentPadding:
                                                                      EdgeInsets.all(
                                                                        8,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                          SizedBox(width: 6),

                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selectedServices
                                                                    .remove(
                                                                      service,
                                                                    );
                                                              });
                                                            },
                                                            child: SvgPicture.asset(
                                                              'assets/svg/trash.svg',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                      SizedBox(height: 14),
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
                                              return AddService(
                                                initialSelected:
                                                    selectedServices,
                                                onSelectionChange: (datas) {
                                                  setState(() {
                                                    selectedServices = datas;
                                                  });
                                                },
                                                // onSelected: (item) {
                                                //   setState(() {
                                                //     selectedServices.add(item);
                                                //   });
                                                // },
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(color: gray300),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 8,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/plus.svg',
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                translateKey.translate(
                                                  'additional_services',
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
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  translateKey.translate('discounts'),
                                  style: TextStyle(
                                    color: gray800,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 14),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: white,
                                    border: Border.all(color: gray300),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      selectedDiscount.isEmpty == true
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 4),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 12,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                    color: gray50,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        '${translateKey.translate('no_discount')}',
                                                        style: TextStyle(
                                                          color: gray400,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: selectedDiscount.map((
                                                service,
                                              ) {
                                                // Initialize defaults if null (Optional logic)
                                                // service.quantity = service.quantity ?? 1;
                                                // service.price = service.price ?? 0;

                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: 10,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              service.type ==
                                                                      "ORDER"
                                                                  ? '${translateKey.translate('Эхний')} ${service.value} ${translateKey.translate('захиалгад')}'
                                                                  : '${service.value} ${translateKey.translate('ба түүнээс дээш хоногоор')}',
                                                              style: TextStyle(
                                                                color: gray700,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 6),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              height: 36,
                                                              decoration: BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                      color:
                                                                          gray300,
                                                                    ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      8,
                                                                    ),
                                                              ),
                                                              child: TextField(
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration: InputDecoration(
                                                                  isDense: true,
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintText:
                                                                      '0%',
                                                                  contentPadding:
                                                                      EdgeInsets.all(
                                                                        8,
                                                                      ),
                                                                ),
                                                                onChanged: (value) {
                                                                  // Save quantity to your model
                                                                  service.procent =
                                                                      int.tryParse(
                                                                        value,
                                                                      );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 6),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selectedDiscount
                                                                    .remove(
                                                                      service,
                                                                    );
                                                              });
                                                            },
                                                            child: SvgPicture.asset(
                                                              'assets/svg/trash.svg',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                      SizedBox(height: 14),
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
                                              return AddDiscount(
                                                initialSelected:
                                                    selectedDiscount,
                                                onSelectionChange: (datas) {
                                                  setState(() {
                                                    selectedDiscount = datas;
                                                  });
                                                },
                                                // onSelected: (item) {
                                                //   setState(() {
                                                //     selectedServices.add(item);
                                                //   });
                                                // },
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(color: gray300),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 8,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/plus.svg',
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                translateKey.translate(
                                                  'add_discount',
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
                                    ],
                                  ),
                                ),

                                SizedBox(height: 16),
                                Text(
                                  translateKey.translate('cancelation_policy'),
                                  style: TextStyle(
                                    color: gray800,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 14),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: white,
                                    border: Border.all(color: gray300),
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      selectedCancelPolicy.isEmpty == true
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 4),

                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 16,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                    border: Border.all(
                                                      color: errorColor,
                                                    ),
                                                    color: errorColor
                                                        .withOpacity(0.1),
                                                  ),
                                                  child: Text(
                                                    '${translateKey.translate('no_cancel_policy_tips')}',
                                                    style: TextStyle(
                                                      color: errorColor
                                                          .withOpacity(0.7),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign:
                                                        TextAlign.justify,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: selectedCancelPolicy.map((
                                                service,
                                              ) {
                                                // service.rate нь int төрөлтэй байх ёстой.
                                                // АНХДАГЧ УТГА: Хэрэв service.rate-д утга оноогдоогүй бол 0-ийг default болгоно.
                                                if (service.rate == null) {
                                                  service.rate = 0;
                                                }

                                                // Сонгох боломжит хувь хэмжээний жагсаалт
                                                final List<int> refundRates = [
                                                  0,
                                                  25,
                                                  50,
                                                  75,
                                                  100,
                                                ];

                                                // Тухайн item-д санал болгох хувийг тодорхойлох
                                                // Индексээр нь тооцоолъё: 0 -> 25, 1 -> 50, 2 -> 75 гэх мэт.
                                                // Энэ нь зөвхөн жишээнд ашиглах логик юм.
                                                final int serviceIndex =
                                                    selectedCancelPolicy
                                                        .indexOf(service);
                                                final int recommendedRateIndex =
                                                    serviceIndex + 1;
                                                final int recommendedRate =
                                                    recommendedRateIndex <
                                                        refundRates.length
                                                    ? refundRates[recommendedRateIndex]
                                                    : refundRates
                                                          .last; // Хэрэв жагсаалтаас хэтэрвэл 100-г авна

                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: 10,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // ... service.name-ийг харуулах хэсэг ...
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              service.name ??
                                                                  '',
                                                              style: TextStyle(
                                                                color: gray700,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 6),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        8,
                                                                  ),
                                                              decoration: BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                      color:
                                                                          gray300,
                                                                    ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      8,
                                                                    ),
                                                              ),
                                                              child: DropdownButtonHideUnderline(
                                                                child: DropdownButtonFormField<int>(
                                                                  isDense: true,
                                                                  value: service
                                                                      .rate!
                                                                      .toInt(),
                                                                  decoration: InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    contentPadding:
                                                                        EdgeInsets.symmetric(
                                                                          vertical:
                                                                              8,
                                                                        ),
                                                                  ),
                                                                  items: refundRates.map((
                                                                    int value,
                                                                  ) {
                                                                    final bool
                                                                    isRecommended =
                                                                        value ==
                                                                        recommendedRate;

                                                                    return DropdownMenuItem<
                                                                      int
                                                                    >(
                                                                      value:
                                                                          value,
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Expanded(
                                                                            child: Text(
                                                                              '$value%',
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 14,
                                                                                color: gray900,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          if (isRecommended)
                                                                            Expanded(
                                                                              child: Text(
                                                                                '(${translateKey.translate('default')})',
                                                                                style: TextStyle(
                                                                                  color: gray900,
                                                                                  fontSize: 12,
                                                                                  fontWeight: FontWeight.w600,
                                                                                ),
                                                                                maxLines: 1,
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }).toList(),
                                                                  onChanged:
                                                                      (
                                                                        int?
                                                                        newValue,
                                                                      ) {
                                                                        if (newValue !=
                                                                            null) {
                                                                          setState(
                                                                            () {
                                                                              service.rate = newValue;
                                                                            },
                                                                          );
                                                                        }
                                                                      },
                                                                  // Сонгогдсон утгыг Dropdown-ийн гадна харуулах хэсэг
                                                                  selectedItemBuilder: (context) {
                                                                    return refundRates.map((
                                                                      int value,
                                                                    ) {
                                                                      return Text(
                                                                        '$value%',
                                                                        style: TextStyle(
                                                                          color:
                                                                              gray900,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      );
                                                                    }).toList();
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 6),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selectedCancelPolicy
                                                                    .remove(
                                                                      service,
                                                                    );
                                                              });
                                                            },
                                                            child: SvgPicture.asset(
                                                              'assets/svg/trash.svg',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                      allRatesAreZero == true
                                          ? Container(
                                              margin: EdgeInsets.only(top: 6),
                                              decoration: BoxDecoration(
                                                color: primary,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 14,
                                                vertical: 8,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    translateKey.translate(
                                                      'no_refund',
                                                    ),
                                                    style: TextStyle(
                                                      color: white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                      SizedBox(height: 14),

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
                                              return AddCancelPolicy(
                                                initialSelected:
                                                    selectedCancelPolicy,
                                                onSelectionChange: (datas) {
                                                  setState(() {
                                                    selectedCancelPolicy =
                                                        datas;
                                                  });
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(color: gray300),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 8,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/plus.svg',
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                translateKey.translate(
                                                  'cancelation_policy',
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
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mediaQuery.padding.bottom + 150,
                                ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: isLoadingButton == true
                                            ? () {}
                                            : () {
                                                onSubmit();
                                              },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: primary,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
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
                                                translateKey.translate('save'),
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
