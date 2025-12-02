// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/models/address.dart';
import 'package:merchant_gerbook_flutter/models/result.dart';
import 'package:merchant_gerbook_flutter/provider/camp_create_provider.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/tools/create_camp_map.dart';
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
  TextEditingController campInfo = TextEditingController();

  Result locationCountryData = Result();
  bool isLoadingPage = true;

  int page = 1;
  int limit = 10;
  Result countData = Result();
  List<Address> countListData = [];
  bool isLoadingCountry = false;

  TextEditingController country = TextEditingController();
  String? selectedCountry;
  MapLibreMapController? mapController;
  Result zones = Result();
  String? selectedZone;
  bool isLoadingButton = false;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      await listCountry(page, limit, level0: 0);
      zones = await ProductApi().getZones();
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

  Address? selectedLevel0;
  Address? selectedLevel1;
  Address? selectedLevel2;
  Address? selectedLevel3;

  LatLng? droppedPin;

  void openMapBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CreateCampMap(
          saveLatLng: (latlng) async {
            Navigator.of(context).pop();
            setState(() {
              droppedPin = latlng;
            });

            await mapController?.addSymbol(
              SymbolOptions(
                geometry: droppedPin,
                iconImage: 'custom-marker',
                iconSize: 3,
              ),
            );
            print('=========lattt=====');
            print(latlng);
            print('=========lattt=====');

            // marker нэмнэ
            // await controller!.addSymbol(
            //   SymbolOptions(
            //     geometry: latlng,
            //     iconImage: 'custom-marker',
            //     iconSize: 1.2,
            //   ),
            // );

            await mapController?.animateCamera(
              CameraUpdate.newLatLngZoom(latlng, 14),
            );
            print('=========lattt=====');
            print(latlng);
            print(mapController);
            print('=========lattt=====');
          },
        );
      },
    );
  }

  bool dropPinError = false;
  bool level0Error = false;
  bool level1Error = false;

  onSubmit() async {
    if (droppedPin == null) {
      setState(() {
        dropPinError = true;
      });
    } else {
      setState(() {
        dropPinError = false;
      });
    }
    if (selectedLevel0 == null) {
      setState(() {
        level0Error = true;
      });
    } else {
      setState(() {
        level0Error = false;
      });
    }
    if (selectedLevel1 == null) {
      setState(() {
        level1Error = true;
      });
    } else {
      setState(() {
        level1Error = false;
      });
    }

    if (fbkey.currentState!.saveAndValidate() &&
        selectedLevel0 != null &&
        selectedLevel1 != null &&
        droppedPin != null) {
      try {
        setState(() {
          isLoadingButton = true;
        });
        print(isLoadingButton);
        print('=====am in ?? =====');
        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateLevel0(
          newLevel0: selectedLevel0 != null ? selectedLevel0!.id! : '',
        );

        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateLevel1(
          newLevel1: selectedLevel1 != null ? selectedLevel1!.id! : '',
        );
        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateLevel2(
          newLevel2: selectedLevel2 != null ? selectedLevel2!.id! : '',
        );
        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateLevel3(
          newLevel3: selectedLevel3 != null ? selectedLevel3!.id! : '',
        );
        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateAddressDetail(newAddressDetail: campInfo.text);
        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateZone(newZone: selectedZone ?? '');
        await Provider.of<CampCreateProvider>(
          context,
          listen: false,
        ).updateLocation(
          newLatitude: droppedPin != null
              ? droppedPin!.latitude.toString()
              : '',
          newLongitude: droppedPin != null
              ? droppedPin!.longitude.toString()
              : '',
        );

        widget.pageController.nextPage(
          duration: Duration(microseconds: 1000),
          curve: Curves.ease,
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
        body: isLoadingPage == true || isLoadingCountry == true
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
                            SizedBox(width: 8),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: white,
                                border: Border.all(color: gray300),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '3/6',
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
                                SizedBox(height: 16),
                                FormBuilder(
                                  key: fbkeyLocation,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CustomDropDown(
                                            searchLevel: 0,
                                            selectedItem: selectedLevel0,
                                            onActive: true,
                                            countyData: countListData,

                                            titleText:
                                                '${translateKey.translate('country')}',
                                            hintText:
                                                '${translateKey.translate('select_country')}',
                                            clearAddress: (level) async {
                                              setState(() {
                                                if (level == 0) {
                                                  selectedLevel0 = null;
                                                  selectedLevel1 = null;
                                                  selectedLevel2 = null;
                                                  selectedLevel3 = null;
                                                } else if (level == 1) {
                                                  selectedLevel1 = null;
                                                  selectedLevel2 = null;
                                                  selectedLevel3 = null;
                                                } else if (level == 2) {
                                                  selectedLevel2 = null;
                                                  selectedLevel3 = null;
                                                } else if (level == 3) {
                                                  selectedLevel3 = null;
                                                }
                                              });
                                              print('===click==clear 0 ===');
                                              print(selectedLevel0);
                                              print(selectedLevel1);
                                              print('===click==clear 0 ===');
                                              await listCountry(
                                                page,
                                                limit,
                                                level0: 0,
                                              );
                                            },
                                            selectedAddress:
                                                (level, data) async {
                                                  setState(() {
                                                    if (level == 0) {
                                                      selectedLevel0 = data;
                                                      selectedLevel1 = null;
                                                      selectedLevel2 = null;
                                                      selectedLevel3 = null;
                                                    } else if (level == 1) {
                                                      selectedLevel1 = null;
                                                      selectedLevel2 = null;
                                                      selectedLevel3 = null;
                                                    } else if (level == 2) {
                                                      selectedLevel2 = null;
                                                      selectedLevel3 = null;
                                                    } else if (level == 3) {
                                                      selectedLevel3 = null;
                                                    }
                                                  });
                                                  print('====test===data===');
                                                  print(level);
                                                  print(data.nameEng);
                                                  print(selectedLevel0);
                                                  print('====test===data===');
                                                  await listCountry(
                                                    page,
                                                    limit,
                                                    parent: selectedLevel0?.id,
                                                    level0: 1,
                                                  );
                                                },

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
                                            searchLevel: 1,
                                            selectedItem: selectedLevel1,
                                            onActive: selectedLevel0 != null
                                                ? true
                                                : false,
                                            countyData: countListData,
                                            titleText: translateKey.translate(
                                              'level_1',
                                            ),
                                            hintText:
                                                '${translateKey.translate('select_city')}',
                                            clearAddress: (level) async {
                                              setState(() {
                                                if (level == 0) {
                                                  selectedLevel0 = null;
                                                  selectedLevel1 = null;
                                                  selectedLevel2 = null;
                                                  selectedLevel3 = null;
                                                } else if (level == 1) {
                                                  selectedLevel1 = null;
                                                  selectedLevel2 = null;
                                                  selectedLevel3 = null;
                                                } else if (level == 2) {
                                                  selectedLevel2 = null;
                                                  selectedLevel3 = null;
                                                } else if (level == 3) {
                                                  selectedLevel3 = null;
                                                }
                                              });
                                              await listCountry(
                                                page,
                                                limit,
                                                parent: selectedLevel0?.id,
                                                level0: 1,
                                              );
                                            },
                                            selectedAddress:
                                                (level, data) async {
                                                  setState(() {
                                                    if (level == 0) {
                                                      selectedLevel0 = null;
                                                      selectedLevel1 = null;
                                                      selectedLevel2 = null;
                                                      selectedLevel3 = null;
                                                    } else if (level == 1) {
                                                      selectedLevel1 = data;
                                                      selectedLevel2 = null;
                                                      selectedLevel3 = null;
                                                    } else if (level == 2) {
                                                      selectedLevel2 = null;
                                                      selectedLevel3 = null;
                                                    } else if (level == 3) {
                                                      selectedLevel3 = null;
                                                    }
                                                  });
                                                  await listCountry(
                                                    page,
                                                    limit,
                                                    parent: selectedLevel1?.id,
                                                    level0: 2,
                                                  );
                                                },
                                            onQueryChanged: (value) async {
                                              await listCountry(
                                                page,
                                                limit,
                                                query: value,
                                                parent: selectedLevel0?.id,
                                                level0: 1,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      level0Error == true || level1Error == true
                                          ? Column(
                                              children: [
                                                SizedBox(height: 6),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    level0Error == false
                                                        ? SizedBox()
                                                        : Expanded(
                                                            child: Text(
                                                              '${translateKey.translate('this_field_is_required')}',
                                                              style: TextStyle(
                                                                color:
                                                                    redButton,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                    level1Error == false
                                                        ? SizedBox()
                                                        : Expanded(
                                                            child: Text(
                                                              '${translateKey.translate('this_field_is_required')}',
                                                              style: TextStyle(
                                                                color:
                                                                    redButton,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    CustomDropDown(
                                      searchLevel: 2,
                                      selectedItem: selectedLevel2,
                                      onActive:
                                          selectedLevel0 != null &&
                                              selectedLevel1 != null
                                          ? true
                                          : false,
                                      countyData: countListData,

                                      titleText: translateKey.translate(
                                        'level_1',
                                      ),
                                      hintText:
                                          '${translateKey.translate('select_state')}',
                                      clearAddress: (level) async {
                                        setState(() {
                                          if (level == 0) {
                                            selectedLevel0 = null;
                                            selectedLevel1 = null;
                                            selectedLevel2 = null;
                                            selectedLevel3 = null;
                                          } else if (level == 1) {
                                            selectedLevel1 = null;
                                            selectedLevel2 = null;
                                            selectedLevel3 = null;
                                          } else if (level == 2) {
                                            selectedLevel2 = null;
                                            selectedLevel3 = null;
                                          } else if (level == 3) {
                                            selectedLevel3 = null;
                                          }
                                        });
                                        await listCountry(
                                          page,
                                          limit,
                                          parent: selectedLevel1?.id,
                                          level0: 2,
                                        );
                                      },
                                      selectedAddress: (level, data) async {
                                        setState(() {
                                          if (level == 0) {
                                            selectedLevel0 = null;
                                            selectedLevel1 = null;
                                            selectedLevel2 = null;
                                            selectedLevel3 = null;
                                          } else if (level == 1) {
                                            selectedLevel1 = null;
                                            selectedLevel2 = null;
                                            selectedLevel3 = null;
                                          } else if (level == 2) {
                                            selectedLevel2 = data;
                                            selectedLevel3 = null;
                                          } else if (level == 3) {
                                            selectedLevel3 = null;
                                          }
                                        });
                                        await listCountry(
                                          page,
                                          limit,
                                          parent: selectedLevel2?.id,
                                          level0: 3,
                                        );
                                      },

                                      onQueryChanged: (value) async {
                                        await listCountry(
                                          page,
                                          limit,
                                          query: value,
                                          parent: selectedLevel1?.id,
                                          level0: 2,
                                        );
                                      },
                                    ),
                                    SizedBox(width: 16),
                                    CustomDropDown(
                                      searchLevel: 3,
                                      selectedItem: selectedLevel3,
                                      onActive:
                                          selectedLevel0 != null &&
                                              selectedLevel1 != null &&
                                              selectedLevel2 != null
                                          ? true
                                          : false,
                                      countyData: countListData,

                                      titleText: translateKey.translate(
                                        'level_3',
                                      ),
                                      hintText:
                                          '${translateKey.translate('level_3')}',
                                      clearAddress: (level) async {
                                        setState(() {
                                          if (level == 0) {
                                            selectedLevel0 = null;
                                            selectedLevel1 = null;
                                            selectedLevel2 = null;
                                            selectedLevel3 = null;
                                          } else if (level == 1) {
                                            selectedLevel1 = null;
                                            selectedLevel2 = null;
                                            selectedLevel3 = null;
                                          } else if (level == 2) {
                                            selectedLevel2 = null;
                                            selectedLevel3 = null;
                                          } else if (level == 3) {
                                            selectedLevel3 = null;
                                          }
                                        });
                                        await listCountry(
                                          page,
                                          limit,
                                          parent: selectedLevel2?.id,
                                          level0: 3,
                                        );
                                      },
                                      selectedAddress: (level, data) async {
                                        setState(() {
                                          if (level == 0) {
                                            selectedLevel0 = null;
                                            selectedLevel1 = null;
                                            selectedLevel2 = null;
                                            selectedLevel3 = null;
                                          } else if (level == 1) {
                                            selectedLevel1 = null;
                                            selectedLevel2 = null;
                                            selectedLevel3 = null;
                                          } else if (level == 2) {
                                            selectedLevel2 = null;
                                            selectedLevel3 = null;
                                          } else if (level == 3) {
                                            selectedLevel3 = data;
                                          }
                                        });
                                        // await listCountry(
                                        //   page,
                                        //   limit,
                                        //   parent: selectedLevel2?.id,
                                        //   level0: 3,
                                        // );
                                      },

                                      onQueryChanged: (value) async {
                                        await listCountry(
                                          page,
                                          limit,
                                          query: value,
                                          parent: selectedLevel2?.id,
                                          level0: 3,
                                        );
                                      },
                                    ),
                                  ],
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
                                        controller: campInfo,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      translateKey.translate('region'),
                                      style: TextStyle(
                                        color: gray700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    DropdownButtonFormField<String>(
                                      icon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          selectedZone != null
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedZone = null;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/svg/close.svg',
                                                        height: 26,
                                                        width: 26,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SvgPicture.asset(
                                                  'assets/svg/drop_down.svg',
                                                ),
                                          SizedBox(width: 12),
                                        ],
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      isDense: true,
                                      isExpanded: false,
                                      decoration: InputDecoration(
                                        // suffixIcon: selectedId != null
                                        //     ? GestureDetector(
                                        //         onTap: () {
                                        //           setState(() {
                                        //             selectedId = null;
                                        //           });
                                        //         },
                                        //         child: Row(
                                        //           children: [
                                        //             SvgPicture.asset(
                                        //               'assets/svg/close.svg',
                                        //               height: 20,
                                        //               width: 20,
                                        //             ),
                                        //             SizedBox(width: 12),
                                        //           ],
                                        //         ),
                                        //       )
                                        //     : null,
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: BorderSide(
                                            color: gray300,
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: BorderSide(
                                            color: gray300,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: BorderSide(
                                            color: gray300,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: BorderSide(
                                            color: gray300,
                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          borderSide: BorderSide(
                                            color: gray300,
                                          ),
                                        ),
                                        border: InputBorder.none,
                                        hintText: translateKey.translate(
                                          'region',
                                        ),
                                        hintMaxLines: 1,
                                        hintStyle: TextStyle(
                                          color: gray500,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        contentPadding: EdgeInsets.all(10),
                                      ),
                                      // decoration: InputDecoration(
                                      //   labelText: 'Байршил сонгох',

                                      //   suffixIcon: selectedId != null
                                      //       ? IconButton(
                                      //           icon: const Icon(
                                      //             Icons.close,
                                      //             color: Colors.grey,
                                      //           ),
                                      //           onPressed: () {
                                      //             setState(() {
                                      //               selectedId = null;
                                      //             });
                                      //           },
                                      //         )
                                      //       : null,
                                      //   border: OutlineInputBorder(
                                      //     borderRadius:
                                      //         BorderRadius.circular(8),
                                      //   ),
                                      // ),
                                      value: selectedZone,
                                      items: zones.rows!.map((item) {
                                        return DropdownMenuItem<String>(
                                          value: item.id,
                                          child: Text(
                                            item.name,
                                            style: TextStyle(
                                              color: gray900,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedZone = value;
                                        });
                                      },
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
                                                    droppedPin != null
                                                        ? '${droppedPin!.latitude}'
                                                        : '0,0',
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
                                                    droppedPin != null
                                                        ? '${droppedPin!.longitude}'
                                                        : '0,0',
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
                                dropPinError == true
                                    ? Column(
                                        children: [
                                          Text(
                                            '${translateKey.translate('this_field_is_required')}',
                                            style: TextStyle(
                                              color: redButton,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                        ],
                                      )
                                    : SizedBox(),
                                // Байршлыг сонгоно уу
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    12,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: gray300),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: mediaQuery.size.width,
                                          height: 300,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadiusGeometry.circular(
                                                  12,
                                                ),
                                            child: MapLibreMap(
                                              styleString:
                                                  'assets/map_style.json',
                                              onMapCreated: (controller) async {
                                                mapController = controller;

                                                final ByteData
                                                bytes = await rootBundle.load(
                                                  'assets/images/map_pin.png',
                                                );
                                                final Uint8List list = bytes
                                                    .buffer
                                                    .asUint8List();
                                                await controller.addImage(
                                                  'custom-marker',
                                                  list,
                                                );
                                              },

                                              onMapClick: (point, coordinates) {
                                                openMapBottomSheet(context);
                                              },
                                              initialCameraPosition:
                                                  CameraPosition(
                                                    target:
                                                        droppedPin ??
                                                        const LatLng(
                                                          47.9189,
                                                          106.9170,
                                                        ),
                                                    zoom: 12.0,
                                                  ),
                                              myLocationEnabled: false,
                                              compassEnabled: false,
                                              zoomGesturesEnabled: false,
                                              scrollGesturesEnabled: false,
                                              attributionButtonMargins:
                                                  const Point(-100, -100),
                                              attributionButtonPosition:
                                                  AttributionButtonPosition
                                                      .topLeft,
                                            ),
                                          ),
                                        ),
                                        if (droppedPin == null)
                                          Positioned.fill(
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () =>
                                                    openMapBottomSheet(context),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          100,
                                                        ),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 42,
                                                        vertical: 10,
                                                      ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
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
                                              isLoadingButton == true
                                                  ? CustomLoader(
                                                      loadColor: white,
                                                    )
                                                  : Text(
                                                      translateKey.translate(
                                                        'continue',
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