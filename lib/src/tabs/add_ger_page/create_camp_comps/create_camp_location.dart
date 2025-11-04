// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/models/address.dart';
import 'package:merchant_gerbook_flutter/models/result.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/tools/custom_drop_down.dart';
import 'package:provider/provider.dart';

class CreateCampLocation extends StatefulWidget {
  final PageController pageController;

  const CreateCampLocation({super.key, required this.pageController});

  @override
  State<CreateCampLocation> createState() => _CreateCampLocationState();
}

class _CreateCampLocationState extends State<CreateCampLocation>
    with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> fbkeyLocation = GlobalKey<FormBuilderState>();
  TextEditingController campCountry = TextEditingController();
  TextEditingController campCity = TextEditingController();

  Result locationCountryData = Result();
  bool isLoadingPage = true;

  int page = 1;
  int limit = 10;
  Result countData = Result();
  List<Address> countListData = [];
  bool isLoadingCountry = false;

  TextEditingController country = TextEditingController();
  String? selectedCountry;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      await listCountry(page, limit, level0: 0);
      // await listPlace(page, limit, level0: 0);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  listCountry(page, limit, {String? query, int? level0, String? parent}) async {
    setState(() {
      isLoadingCountry = true;
    });
    countListData = await ProductApi().getCountryAddress(
      ResultArguments(
        page: page,
        limit: limit,
        query: query,
        levels0: level0,
        parent: parent != null ? parent : null,
      ),
    );
    setState(() {
      isLoadingCountry = false;
    });
  }

  String? level0Id;
  String? level0Name;
  String? level1Id;
  String? level1Name;
  String? level2Id;
  String? level2Name;
  String? level3Id;
  String? level3Name;
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
                            SvgPicture.asset('assets/svg/selected_step.svg'),
                            Expanded(
                              child: Container(height: 2, color: gray200),
                            ),
                            SvgPicture.asset('assets/svg/unselected_step.svg'),
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
                                    translateKey.translate('address_title'),
                                    style: TextStyle(
                                      color: gray800,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '${translateKey.translate('address_details')}',
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
                              children: [
                                SizedBox(height: 16),
                                FormBuilder(
                                  key: fbkeyLocation,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CustomDropDown(
                                            titleText:
                                                '${translateKey.translate('country')}',
                                            hintText:
                                                '${translateKey.translate('select_country')}',
                                            countId: (value) async {
                                              print('=====text====id');
                                              print(value);
                                              print('=====text====id');

                                              setState(() {
                                                level0Id = value;
                                              });
                                              await listCountry(
                                                page,
                                                limit,
                                                // query: value,
                                                level0: 1,
                                                parent: value,
                                              );
                                            },
                                            textController: (value) {
                                              print('=====text====value');
                                              print(value);
                                              print('=====text====value');

                                              setState(() {
                                                level0Name = value;
                                              });
                                            },
                                            countyData: countListData,
                                            onQueryChanged: (value) async {
                                              await listCountry(
                                                page,
                                                limit,
                                                query: value,
                                                level0: 0,
                                              );
                                            },
                                          ),
                                          SizedBox(width: 16),
                                          CustomDropDown(
                                            titleText: translateKey.translate(
                                              'level_1',
                                            ),
                                            hintText:
                                                '${translateKey.translate('select_city')}',
                                            countId: (value) {
                                              print('=====text====id');
                                              print(value);
                                              print('=====text====id');

                                              setState(() {
                                                level1Id = value;
                                              });
                                            },
                                            textController: (value) {
                                              print('=====text====value');
                                              print(value);
                                              print('=====text====value');

                                              setState(() {
                                                level1Name = value;
                                              });
                                            },
                                            countyData: countListData,
                                            onQueryChanged: (value) async {
                                              await listCountry(
                                                page,
                                                limit,
                                                query: value,

                                                level0: 0,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        children: [
                                          CustomDropDown(
                                            titleText: translateKey.translate(
                                              'level_2',
                                            ),
                                            hintText:
                                                '${translateKey.translate('select_state')}',
                                            countId: (value) {
                                              print('=====text====id');
                                              print(value);
                                              print('=====text====id');

                                              setState(() {
                                                level2Id = value;
                                              });
                                            },
                                            textController: (value) {
                                              print('=====text====value');
                                              print(value);
                                              print('=====text====value');

                                              setState(() {
                                                level2Name = value;
                                              });
                                            },
                                            countyData: countListData,
                                            onQueryChanged: (value) async {
                                              await listCountry(
                                                page,
                                                limit,
                                                query: value,

                                                level0: 0,
                                              );
                                            },
                                          ),

                                          SizedBox(width: 16),
                                          CustomDropDown(
                                            titleText: translateKey.translate(
                                              'level_3',
                                            ),
                                            hintText:
                                                '${translateKey.translate('level_3')}',
                                            countId: (value) {
                                              print('=====text====id');
                                              print(value);
                                              print('=====text====id');

                                              setState(() {
                                                level3Id = value;
                                              });
                                            },
                                            textController: (value) {
                                              print('=====text====value');
                                              print(value);
                                              print('=====text====value');

                                              setState(() {
                                                level3Name = value;
                                              });
                                            },
                                            countyData: countListData,
                                            onQueryChanged: (value) async {
                                              await listCountry(
                                                page,
                                                limit,
                                                query: value,
                                                level0: 0,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                FormBuilder(
                                  key: fbkey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FormTextField(
                                        inputType: TextInputType.text,
                                        controller: campCity,
                                        colortext: black,
                                        name: 'campInfo',
                                        color: white,
                                        suffixIcon: null,
                                        hintText:
                                            "${translateKey.translate('address_details')}",
                                        hintTextColor: gray500,
                                        labelColor: gray700,
                                        labelText:
                                            "${translateKey.translate('address_title')}",
                                        maxLines: 5,
                                        validator: FormBuilderValidators.compose(
                                          [
                                            FormBuilderValidators.required(
                                              errorText: translateKey.translate(
                                                'ta_uuriyn_medeelliyg_65b43f00',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
                                            translateKey.translate('longitude'),
                                            style: TextStyle(
                                              color: gray700,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: gray300,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: white,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 10,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '0,0',
                                                    style: TextStyle(
                                                      color: gray900,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
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
                                            translateKey.translate('latitude'),
                                            style: TextStyle(
                                              color: gray700,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 6),

                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: gray300,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: white,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 10,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '0,0',
                                                    style: TextStyle(
                                                      color: gray900,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    12,
                                  ),
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        'assets/images/zurag.png',
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: primary,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 42,
                                                vertical: 10,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    translateKey.translate(
                                                      'mark_on_map',
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
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: mediaQuery.padding.bottom + 100,
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
/*
Expanded(
                                                      child: DropdownSearch<Address>(
                                                        autoValidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                        // suffixProps: ,
                                                        mode: Mode.custom,
                                                        dropdownBuilder: (ctx, selectedItem) => Container(
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
                                                                horizontal: 14,
                                                                vertical: 10,
                                                              ),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  '${selectedItem != null ? selectedItem.nameEng : translateKey.translate('select_country')}',
                                                                  style: TextStyle(
                                                                    color:
                                                                        selectedItem !=
                                                                            null
                                                                        ? gray900
                                                                        : gray500,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                              SvgPicture.asset(
                                                                'assets/svg/drop_down.svg',
                                                              ),
                                                            ],
                                                          ),
                                                        ),

                                                        items: (filter, loadProps) {
                                                          return countListData
                                                              .where(
                                                                (item) => item
                                                                    .nameEng!
                                                                    .toLowerCase()
                                                                    .contains(
                                                                      filter
                                                                          .toLowerCase(),
                                                                    ),
                                                              )
                                                              .toList();
                                                        },

                                                        itemAsString:
                                                            (Address u) =>
                                                                u.nameEng!,
                                                        onChanged: (Address? data) {
                                                          setState(() {
                                                            selectedCountry =
                                                                data?.id;
                                                            country.text =
                                                                data?.nameEng ??
                                                                '';
                                                          });
                                                        },
                                                        compareFn:
                                                            (item1, item2) =>
                                                                item1.id ==
                                                                item2.id,
                                                        popupProps: PopupProps.menu(
                                                          showSearchBox: true,
                                                          showSelectedItems:
                                                              true,
                                                          fit: FlexFit.loose,
                                                          scrollbarProps:
                                                              ScrollbarProps(
                                                                thumbColor:
                                                                    transparent,
                                                                trackColor:
                                                                    transparent,
                                                                trackBorderColor:
                                                                    transparent,
                                                              ),
                                                          searchFieldProps: TextFieldProps(
                                                            autocorrect: false,
                                                            // onChanged:
                                                            //     (value) async {
                                                            //       await listCountry(
                                                            //         page,
                                                            //         limit,
                                                            //         query:
                                                            //             value,
                                                            //         level0: 0,
                                                            //       );
                                                            //     },
                                                            autofocus: true,
                                                            decoration: InputDecoration(
                                                              errorBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      8,
                                                                    ),
                                                                borderSide:
                                                                    BorderSide(
                                                                      color:
                                                                          gray300,
                                                                    ),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          8,
                                                                        ),
                                                                    borderSide:
                                                                        BorderSide(
                                                                          color:
                                                                              gray300,
                                                                        ),
                                                                  ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      8,
                                                                    ),
                                                                borderSide:
                                                                    BorderSide(
                                                                      color:
                                                                          gray300,
                                                                    ),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      8,
                                                                    ),
                                                                borderSide:
                                                                    BorderSide(
                                                                      color:
                                                                          gray300,
                                                                    ),
                                                              ),
                                                              disabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      8,
                                                                    ),
                                                                borderSide:
                                                                    BorderSide(
                                                                      color:
                                                                          gray300,
                                                                    ),
                                                              ),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  '${translateKey.translate('country')} ${translateKey.translate('search').toLowerCase()}',
                                                              hintMaxLines: 1,
                                                              hintStyle: TextStyle(
                                                                color: gray500,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets.all(
                                                                    10,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
 */