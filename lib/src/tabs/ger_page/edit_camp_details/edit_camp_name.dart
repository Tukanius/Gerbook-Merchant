import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class EditCampName extends StatefulWidget {
  static const routeName = "EditCampName";

  const EditCampName({super.key});

  @override
  State<EditCampName> createState() => _EditCampNameState();
}

class _EditCampNameState extends State<EditCampName> {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  TextEditingController campName = TextEditingController();
  TextEditingController campInfo = TextEditingController();
  // TextEditingController campBed = TextEditingController(text: '0');
  // TextEditingController campNumber = TextEditingController(text: '0');
  bool isLoading = false;
  int bedCount = 0;
  int campCount = 0;
  bool isLoadingButton = false;
  @override
  void initState() {
    super.initState();
    campName.addListener(() {
      setState(() {});
    });
    campInfo.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    campName.dispose();
    campInfo.dispose();
    super.dispose();
  }

  onSubmit() async {
    // if (fbkey.currentState!.saveAndValidate()) {
    //   try {
    //     setState(() {
    //       isLoadingButton = true;
    //     });
    //     await Provider.of<CampCreateProvider>(
    //       context,
    //       listen: false,
    //     ).updateNameAndInfo(
    //       newName: campName.text.trim(),
    //       newDescription: campInfo.text.trim(),
    //     );

    //     setState(() {
    //       isLoadingButton = false;
    //     });
    //   } catch (e) {
    //     setState(() {
    //       isLoadingButton = false;
    //     });
    //   }
    // }
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
                              translateKey.translate('camp_info'),
                              style: TextStyle(
                                color: gray800,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '${translateKey.translate('camp_info_fill')}',
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
                            key: fbkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormTextField(
                                  inputType: TextInputType.text,
                                  controller: campName,
                                  colortext: black,
                                  name: 'name',
                                  color: white,
                                  hintText:
                                      "${translateKey.translate('please_camp_name')}",
                                  hintTextColor: gray500,
                                  labelColor: gray700,
                                  labelText:
                                      "${translateKey.translate('camp_name')} ",
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText: translateKey.translate(
                                        'ta_uuriyn_medeelliyg_65b43f00',
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox(height: 16),
                                FormTextField(
                                  inputType: TextInputType.text,
                                  controller: campInfo,
                                  colortext: black,
                                  name: 'description',
                                  color: white,
                                  suffixIcon: null,
                                  hintText:
                                      "${translateKey.translate('please_camp_info')}",
                                  hintTextColor: gray500,
                                  labelColor: gray700,
                                  labelText:
                                      "${translateKey.translate('description')}",
                                  maxLines: 5,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText: translateKey.translate(
                                        'ta_uuriyn_medeelliyg_65b43f00',
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),

                          SizedBox(height: mediaQuery.padding.bottom + 80),
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
                              // Expanded(
                              //   child: GestureDetector(
                              //     onTap: () {
                              //       widget.pageController.previousPage(
                              //         duration: Duration(microseconds: 1000),
                              //         curve: Curves.ease,
                              //       );
                              //     },
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //         color: white,
                              //         border: Border.all(color: gray300),
                              //         borderRadius: BorderRadius.circular(8),
                              //       ),
                              //       padding: EdgeInsets.symmetric(
                              //         horizontal: 24,
                              //         vertical: 10,
                              //       ),
                              //       child: Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         children: [
                              //           Text(
                              //             translateKey.translate(
                              //               'navigation_back',
                              //             ),
                              //             style: TextStyle(
                              //               color: gray700,
                              //               fontSize: 14,
                              //               fontWeight: FontWeight.w600,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(width: 16),
                              Expanded(
                                child: GestureDetector(
                                  onTap:
                                      isLoadingButton == true ||
                                          campName.text == "" ||
                                          campInfo.text == ""
                                      ? () {}
                                      : () {
                                          onSubmit();
                                        },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          campName.text == "" ||
                                              campInfo.text == ""
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

                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Text(
                          //             translateKey.translate('bed_numbers'),
                          //             style: TextStyle(
                          //               color: gray700,
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.w500,
                          //             ),
                          //           ),
                          //           SizedBox(height: 6),
                          //           Container(
                          //             decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(
                          //                 100,
                          //               ),
                          //               color: white,
                          //               border: Border.all(color: gray300),
                          //             ),
                          //             padding: EdgeInsets.symmetric(
                          //               horizontal: 12,
                          //               vertical: 8,
                          //             ),
                          //             child: Row(
                          //               children: [
                          //                 // ➕ Нэмэх товч
                          //                 InkWell(
                          //                   onTap: () {
                          //                     setState(() {
                          //                       bedCount++;
                          //                       campBed.text = bedCount
                          //                           .toString();
                          //                     });
                          //                   },
                          //                   child: SvgPicture.asset(
                          //                     'assets/svg/plus.svg',
                          //                     height: 24,
                          //                     width: 24,
                          //                   ),
                          //                 ),

                          //                 SizedBox(width: 8),

                          //                 // Тоо харуулах input
                          //                 Expanded(
                          //                   child: TextField(
                          //                     controller: campBed,
                          //                     keyboardType:
                          //                         TextInputType.number,
                          //                     textAlign: TextAlign.center,
                          //                     style: TextStyle(
                          //                       color: gray800,
                          //                       fontSize: 18,
                          //                       fontWeight: FontWeight.w500,
                          //                     ),
                          //                     decoration: const InputDecoration(
                          //                       border: InputBorder.none,
                          //                       isDense: true,
                          //                       contentPadding: EdgeInsets.zero,
                          //                     ),
                          //                     onChanged: (value) {
                          //                       setState(() {
                          //                         int parsed =
                          //                             int.tryParse(value) ?? 0;
                          //                         if (parsed < 0) parsed = 0;
                          //                         bedCount = parsed;
                          //                         campBed.text = bedCount
                          //                             .toString();
                          //                         campBed.selection =
                          //                             TextSelection.fromPosition(
                          //                               TextPosition(
                          //                                 offset: campBed
                          //                                     .text
                          //                                     .length,
                          //                               ),
                          //                             );
                          //                       });
                          //                     },
                          //                   ),
                          //                 ),
                          //                 SizedBox(width: 8),
                          //                 InkWell(
                          //                   onTap: () {
                          //                     setState(() {
                          //                       if (bedCount > 0) {
                          //                         bedCount--;
                          //                         campBed.text = bedCount
                          //                             .toString();
                          //                       }
                          //                     });
                          //                   },
                          //                   child: SvgPicture.asset(
                          //                     'assets/svg/minus.svg',
                          //                     height: 24,
                          //                     width: 24,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     SizedBox(width: 16),
                          //     Expanded(
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Text(
                          //             translateKey.translate('ger_count'),
                          //             style: TextStyle(
                          //               color: gray700,
                          //               fontSize: 14,
                          //               fontWeight: FontWeight.w500,
                          //             ),
                          //           ),
                          //           SizedBox(height: 6),
                          //           Container(
                          //             decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(
                          //                 100,
                          //               ),
                          //               color: white,
                          //               border: Border.all(color: gray300),
                          //             ),
                          //             padding: EdgeInsets.symmetric(
                          //               horizontal: 12,
                          //               vertical: 8,
                          //             ),
                          //             child: Row(
                          //               children: [
                          //                 InkWell(
                          //                   onTap: () {
                          //                     setState(() {
                          //                       campCount++;
                          //                       campNumber.text = campCount
                          //                           .toString();
                          //                     });
                          //                   },
                          //                   child: SvgPicture.asset(
                          //                     'assets/svg/plus.svg',
                          //                     height: 24,
                          //                     width: 24,
                          //                   ),
                          //                 ),
                          //                 SizedBox(width: 8),
                          //                 Expanded(
                          //                   child: TextField(
                          //                     controller: campNumber,
                          //                     keyboardType:
                          //                         TextInputType.number,
                          //                     textAlign: TextAlign.center,
                          //                     style: TextStyle(
                          //                       color: gray800,
                          //                       fontSize: 18,
                          //                       fontWeight: FontWeight.w500,
                          //                     ),
                          //                     decoration: const InputDecoration(
                          //                       border: InputBorder.none,
                          //                       isDense: true,
                          //                       contentPadding: EdgeInsets.zero,
                          //                     ),
                          //                     onChanged: (value) {
                          //                       setState(() {
                          //                         int parsed =
                          //                             int.tryParse(value) ?? 0;
                          //                         if (parsed < 0) parsed = 0;
                          //                         campCount = parsed;
                          //                         campNumber.text = campCount
                          //                             .toString();
                          //                         campNumber.selection =
                          //                             TextSelection.fromPosition(
                          //                               TextPosition(
                          //                                 offset: campNumber
                          //                                     .text
                          //                                     .length,
                          //                               ),
                          //                             );
                          //                       });
                          //                     },
                          //                   ),
                          //                 ),
                          //                 SizedBox(width: 8),
                          //                 InkWell(
                          //                   onTap: () {
                          //                     setState(() {
                          //                       if (campCount > 0) {
                          //                         campCount--;
                          //                         campNumber.text = campCount
                          //                             .toString();
                          //                       }
                          //                     });
                          //                   },
                          //                   child: SvgPicture.asset(
                          //                     'assets/svg/minus.svg',
                          //                     height: 24,
                          //                     width: 24,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),