// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchant_gerbook_flutter/api/auth_api.dart';
import 'package:merchant_gerbook_flutter/components/dialog_component/success_dialog.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/splash_page/splash_page.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class DeactivateBottomSheet extends StatefulWidget {
  final User deactivate;
  const DeactivateBottomSheet({super.key, required this.deactivate});

  @override
  State<DeactivateBottomSheet> createState() => _DeactivateBottomSheetState();
}

class _DeactivateBottomSheetState extends State<DeactivateBottomSheet>
    with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  TextEditingController controller = TextEditingController();

  bool isLoading = true;
  User checkOtp = User();
  User user = User();
  bool isGetCode = false;
  int _counter = 120;
  late Timer _timer;
  bool isSubmit = false;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    _startTimer();
    // await onDeactivate();
    setState(() {
      isLoading = false;
    });
  }

  // onDeactivate() async {
  //   try {
  //     user = await AuthApi().accountDeactivate();

  //     // Navigator.of(context).pushNamed(SplashPage.routeName);
  //     // showSuccess(context, 'Your account has been successfully deactivated.');
  //     // print(res);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  checkOpt(value) async {
    final local = Provider.of<LocalizationProvider>(context, listen: false);

    try {
      checkOtp.otpCode = value;
      await AuthApi().deactivateVerify(checkOtp);
      showSuccessDialog(context, local.translate('deactivated_success'));
      Navigator.of(context).popAndPushNamed(SplashPage.routeName);
    } catch (e) {
      controller.clear();
      print(e.toString());
    }
  }

  void _startTimer() async {
    if (isSubmit == true) {
      setState(() {
        isGetCode = false;
      });
      _counter = 180;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_counter > 0) {
          setState(() {
            _counter--;
          });
        } else {
          setState(() {
            isGetCode = true;
          });
          _timer.cancel();
        }
      });
    } else {
      setState(() {
        isGetCode = false;
      });
      _counter = 180;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_counter > 0) {
          setState(() {
            _counter--;
          });
        } else {
          setState(() {
            isGetCode = true;
          });
          _timer.cancel();
        }
      });
    }
  }

  String intToTimeLeft(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);
    String minutes = m.toString().padLeft(2, '0');
    String seconds = s.toString().padLeft(2, '0');
    String result = "$minutes:$seconds";
    return result;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
    width: 51,
    height: 51,
    textStyle: TextStyle(
      fontSize: 16,
      color: primary,
      fontWeight: FontWeight.w700,
    ),
    decoration: BoxDecoration(
      color: pinColor,
      border: Border.all(color: gray200),
      borderRadius: BorderRadius.circular(8),
    ),
  );
  @override
  Widget build(BuildContext context) {
    // final bool isKeyboardVisible =
    //     KeyboardVisibilityProvider.isKeyboardVisible(context);
    final local = Provider.of<LocalizationProvider>(context, listen: true);

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: white,
      ),
      child: isLoading == true
          ? Container(
              height: 250,
              child: Center(child: CircularProgressIndicator(color: primary)),
            )
          : Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        local.translate('deactive_account'),
                        style: TextStyle(
                          color: blackText,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 15),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.deactivate.message}",
                            style: TextStyle(
                              color: darkBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 16),
                          Pinput(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            closeKeyboardWhenCompleted: true,
                            onCompleted: (value) => checkOpt(value),
                            controller: controller,
                            // validator: (value) {
                            //   return value == "${user.otpCode}"
                            //       ? null
                            //       : local.translate('verification_incorrect');
                            // },
                            length: 6,
                            hapticFeedbackType: HapticFeedbackType.lightImpact,
                            defaultPinTheme: defaultPinTheme,
                            errorPinTheme: defaultPinTheme.copyBorderWith(
                              border: Border.all(color: errorColor),
                            ),
                            errorTextStyle: TextStyle(
                              color: errorColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svg/clock.svg'),
                                  SizedBox(width: 4),
                                  Text(
                                    '${_counter} ${local.translate('sec')}',
                                    style: TextStyle(
                                      color: darkBlue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              isGetCode == false
                                  ? SizedBox()
                                  : GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          isSubmit = true;
                                        });
                                        _startTimer();
                                        user = await AuthApi()
                                            .accountDeactivate();
                                      },
                                      child: Text(
                                        local.translate('resend'),
                                        style: TextStyle(
                                          color: textBlue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          // SizedBox(height: 16),
                          // CustomButton(
                          //   isLoading: false,
                          //   onClick: () {
                          //     Navigator.of(context)
                          //         .pushNamed(PasswordPage.routeName);
                          //   },
                          //   buttonColor: primary,
                          //   textColor: white,
                          //   labelText: 'Verify',
                          // ),
                        ],
                      ),
                      SizedBox(height: 15),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {},
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(6),
                      //           color: primary,
                      //         ),
                      //         child: Padding(
                      //           padding:
                      //               EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      //           child: Text(
                      //             'Save',
                      //             style: TextStyle(
                      //               color: white,
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
