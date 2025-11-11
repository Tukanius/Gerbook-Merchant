// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/result.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class CreateCampTags extends StatefulWidget {
  final PageController pageController;

  const CreateCampTags({super.key, required this.pageController});

  @override
  State<CreateCampTags> createState() => _CreateCampTagsState();
}

class _CreateCampTagsState extends State<CreateCampTags> with AfterLayoutMixin {
  bool isLoadingPage = true;

  List<String> filterTag = [];
  List<String> filterOffer = [];
  List<String> filterTagName = [];
  List<String> filterOfferName = [];

  List<String> discountDatas = [];

  int page = 1;
  int limit = 30;
  Result placeOffers = Result();
  bool isLoadingOffers = true;
  Result placeTags = Result();
  bool isLoadingTags = true;
  bool isSmoke = false;
  bool isPets = false;
  bool is4Season = false;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      await listOfPlaceOffers(page, limit);
      await listOfTags(page, limit);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
    // print('======test========');
    // print(widget.priceMinText);
    // print(widget.priceMaxText);
    // print(widget.priceMinText == null);
    // print(widget.priceMaxText == null);

    // print('======test========');

    // setState(() {
    //   min.text = widget.priceMinText != null
    //       ? widget.priceMinText.toString()
    //       : '';
    //   max.text = widget.priceMaxText != null
    //       ? widget.priceMaxText.toString()
    //       : '';

    //   filterTag = widget.filterTagSelected ?? [];
    //   filterOffer = widget.filterOfferSelected ?? [];
    // });
  }

  listOfTags(page, limit, {String? query}) async {
    placeTags = await ProductApi().getPlaceTags(
      ResultArguments(page: page, limit: limit),
    );
    setState(() {
      isLoadingTags = false;
    });
  }

  listOfPlaceOffers(page, limit, {String? query}) async {
    placeOffers = await ProductApi().getPlaceOffersList(
      ResultArguments(page: page, limit: limit, query: query),
    );
    setState(() {
      isLoadingOffers = false;
    });
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
      child: isLoadingPage == true
          ? CustomLoader()
          : Scaffold(
              backgroundColor: white,
              body: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset('assets/svg/completed_step.svg'),
                            Expanded(
                              child: Container(height: 2, color: gray200),
                            ),
                            SvgPicture.asset('assets/svg/completed_step.svg'),
                            Expanded(
                              child: Container(height: 2, color: gray200),
                            ),
                            SvgPicture.asset('assets/svg/completed_step.svg'),
                            Expanded(
                              child: Container(height: 2, color: gray200),
                            ),
                            SvgPicture.asset('assets/svg/selected_step.svg'),
                            Expanded(
                              child: Container(height: 2, color: gray200),
                            ),
                            SvgPicture.asset('assets/svg/unselected_step.svg'),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
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
                                      children: placeOffers.rows!.map((item) {
                                        bool isSelected = filterOffer.contains(
                                          item.id,
                                        );
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isSelected) {
                                                filterOffer.remove(item.id);
                                                filterOfferName.remove(
                                                  item.name,
                                                );
                                              } else {
                                                filterOffer.add(item.id!);
                                                filterOfferName.add(item.name!);
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                color: isSelected
                                                    ? primary
                                                    : gray200,
                                              ),
                                              color: isSelected
                                                  ? primary
                                                  : white,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.network(
                                                  height: 22,
                                                  width: 22,
                                                  '${item.image!.url}',
                                                  fit: BoxFit.contain,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  translateKey.translate(
                                                    '${item.name}',
                                                  ),
                                                  // '${item.name}',
                                                  style: TextStyle(
                                                    color: isSelected
                                                        ? white
                                                        : gray800,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      translateKey.translate('tags'),
                                      style: TextStyle(
                                        color: gray500,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Wrap(
                                      spacing: 6,
                                      runSpacing: 6,
                                      children: placeTags.rows!.map((item) {
                                        bool isSelected = filterTag.contains(
                                          item.id,
                                        );
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (isSelected) {
                                                filterTag.remove(item.id);
                                                filterTagName.remove(
                                                  item.name!,
                                                );
                                              } else {
                                                filterTag.add(item.id!);
                                                filterTagName.add(item.name!);
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                color: isSelected
                                                    ? primary
                                                    : gray200,
                                              ),
                                              color: isSelected
                                                  ? primary
                                                  : white,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                isSelected
                                                    ? Image.network(
                                                        height: 20,
                                                        width: 20,
                                                        '${item.selectedIcon}',
                                                        fit: BoxFit.contain,
                                                      )
                                                    : Image.network(
                                                        height: 20,
                                                        width: 20,
                                                        '${item.icon}',
                                                        fit: BoxFit.contain,
                                                      ),
                                                SizedBox(width: 5),
                                                Text(
                                                  translateKey.translate(
                                                    '${item.name}',
                                                  ),
                                                  // '${item.name}',
                                                  style: TextStyle(
                                                    color: isSelected
                                                        ? white
                                                        : gray800,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      translateKey.translate('is_smoking'),
                                      style: TextStyle(
                                        color: gray700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 24 / 32,
                                      child: Switch.adaptive(
                                        value: isSmoke,
                                        onChanged: (value) =>
                                            setState(() => isSmoke = value),
                                        activeColor: primary,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      translateKey.translate('is_pets'),
                                      style: TextStyle(
                                        color: gray700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 24 / 32,
                                      child: Switch.adaptive(
                                        value: isPets,
                                        onChanged: (value) =>
                                            setState(() => isPets = value),
                                        activeColor: primary,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${translateKey.translate('whether_the_property_all_seasons')}',
                                        style: TextStyle(
                                          color: gray700,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Transform.scale(
                                      alignment: Alignment.centerRight,
                                      scale: 24 / 32,
                                      child: Switch.adaptive(
                                        value: is4Season,
                                        onChanged: (value) =>
                                            setState(() => is4Season = value),
                                        activeColor: primary,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            translateKey.translate(
                                              'check_out_time',
                                            ),
                                            style: TextStyle(
                                              color: gray700,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: white,
                                              border: Border.all(
                                                color: gray300,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '--:--',
                                                  style: TextStyle(
                                                    color: gray700,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(width: 6),
                                                SvgPicture.asset(
                                                  'assets/svg/clock.svg',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            translateKey.translate(
                                              'check_in_time',
                                            ),
                                            style: TextStyle(
                                              color: gray700,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: white,
                                              border: Border.all(
                                                color: gray300,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '--:--',
                                                  style: TextStyle(
                                                    color: gray700,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(width: 6),
                                                SvgPicture.asset(
                                                  'assets/svg/clock.svg',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),

                                Text(
                                  translateKey.translate('discount'),
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
                                      discountDatas.isEmpty == true
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 4),

                                                Center(
                                                  child: Text(
                                                    '${translateKey.translate('no_discount')}',
                                                    style: TextStyle(
                                                      color: gray700,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [1, 2, 3]
                                                  .map(
                                                    (data) => Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          translateKey
                                                              .translate(
                                                                'add_discount',
                                                              ),
                                                          style: TextStyle(
                                                            color: gray700,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        SizedBox(height: 6),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                            color: white,
                                                            border: Border.all(
                                                              color: gray300,
                                                            ),
                                                          ),
                                                          padding:
                                                              EdgeInsets.symmetric(
                                                                horizontal: 16,
                                                                vertical: 10,
                                                              ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '-',
                                                                style: TextStyle(
                                                                  color:
                                                                      gray700,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Text(
                                                                '%',
                                                                style: TextStyle(
                                                                  color:
                                                                      primary,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                      SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: primary,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
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
                                                        'add_discount',
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
                                              ),
                                            ),
                                          ),
                                        ],
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
                                        onTap: () {
                                          widget.pageController.previousPage(
                                            duration: Duration(
                                              microseconds: 1000,
                                            ),
                                            curve: Curves.ease,
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: white,
                                            border: Border.all(color: gray300),
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
                                            duration: Duration(
                                              microseconds: 1000,
                                            ),
                                            curve: Curves.ease,
                                          );
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
