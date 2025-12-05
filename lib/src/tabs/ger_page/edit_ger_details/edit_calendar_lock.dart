// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/models/calendar.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';



class EditCalendarLock extends StatefulWidget {
  final String id;
  final String date;
  const EditCalendarLock({super.key, required this.id, required this.date});

  @override
  State<EditCalendarLock> createState() => _EditCalendarLockState();
}

class _EditCalendarLockState extends State<EditCalendarLock>
    with AfterLayoutMixin {
  bool isLoadingButton = false;
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  TextEditingController controllerUrl = TextEditingController();
  bool isLoadingPage = true;
  User user = User();
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await callUser();
  }

  callUser() async {
    try {
      setState(() {
        isLoadingPage = true;
      });
      // user = await AuthApi().me(false);
      // if (widget.type == "firstName") {
      //   controllerUrl.text = user.firstName ?? '';
      // } else if (widget.type == "lastName") {
      //   controllerUrl.text = user.lastName ?? '';
      // } else if (widget.type == "registerNo") {
      //   controllerUrl.text = user.registerNo ?? '';
      // }
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoadingButton = true;
        });
        Calendar data = Calendar();
        data.date = widget.date;

        if (tabIndex == 0) {
          data.price = int.parse(controllerUrl.text);
          data.blockedQuantity = 0;
        } else if (tabIndex == 1) {
          data.blockedQuantity = int.parse(controllerUrl.text);
          data.blockedQuantity = 0;
        }
        // User data = User();
        // if (widget.type == "firstName") {
        //   data.firstName = controllerUrl.text;
        //   data.lastName = user.lastName ?? '';
        //   data.registerNo = user.registerNo ?? '';
        // } else if (widget.type == "lastName") {
        //   data.firstName = user.firstName ?? '';
        //   data.lastName = controllerUrl.text;
        //   data.registerNo = user.registerNo ?? '';
        // } else if (widget.type == "registerNo") {
        //   data.firstName = user.firstName ?? '';
        //   data.lastName = user.lastName ?? '';
        //   data.registerNo = controllerUrl.text;
        // }
        await ProductApi().editGerCalendar(data, widget.id);
        Navigator.of(context).pop(true);
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

  int tabIndex = 0;

  void changeTabIndex(int index) async {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Container(
      // height: mediaQuery.size.height * 0.9,
      width: mediaQuery.size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: white,
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${translateKey.translate('price_control')}',
                  style: TextStyle(
                    color: black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  '${translateKey.translate('price_control_description')}',
                  style: TextStyle(
                    color: gray600,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              SizedBox(width: 16),
              SvgPicture.asset(
                'assets/svg/calendar.svg',
                height: 24,
                width: 24,
                color: black,
              ),
              SizedBox(width: 8),
              Text(
                '2025-12-05',
                style: TextStyle(
                  color: black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translateKey.translate('daily_price'),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              translateKey.translate('house_lock'),
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
          SizedBox(height: 12),
          FormBuilder(
            key: fbkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormTextField(
                    inputType: TextInputType.number,
                    controller: controllerUrl,
                    colortext: black,
                    name: 'names',
                    color: white,
                    suffixIcon: null,
                    hintText: tabIndex == 0
                        ? "${translateKey.translate('price')}"
                        : "${translateKey.translate('number_of_locked_houses')}",
                    hintTextColor: gray500,
                    labelColor: gray700,
                    labelText: tabIndex == 0
                        ? "${translateKey.translate('price')}"
                        : "${translateKey.translate('number_of_locked_houses')}",
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
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: isLoadingButton == true
                    ? () {}
                    : () async {
                        await onSubmit();
                      },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primary,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: isLoadingButton == true
                      ? CustomLoader(loadColor: white)
                      : Text(
                          '${translateKey.translate('save')}',
                          style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(
            height: Platform.isIOS
                ? mediaQuery.padding.bottom
                : mediaQuery.padding.bottom + 16,
          ),
        ],
      ),
    );
  }
}
