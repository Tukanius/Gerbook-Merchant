import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:merchant_gerbook_flutter/api/auth_api.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_button.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpModal extends StatefulWidget {
  final String userName;
  final String type;
  final User user;

  static const routeName = 'OtpModal';
  const OtpModal({
    super.key,
    required this.userName,
    required this.type,
    required this.user,
  });

  @override
  State<OtpModal> createState() => _OtpModalState();
}

class _OtpModalState extends State<OtpModal> with AfterLayoutMixin {
  TextEditingController pinput = TextEditingController();
  bool isLoading = false;
  bool isLoadingPage = true;
  User user = User();
  User checkOtp = User();

  bool isSubmit = false;
  bool isGetCode = false;
  int _counter = 60;

  late Timer _timer;

  final defaultPinTheme = PinTheme(
    // width: 60,
    padding: EdgeInsets.all(0),

    height: 40,
    textStyle: TextStyle(
      fontSize: 16,
      color: black,
      fontWeight: FontWeight.w700,
    ),
    decoration: BoxDecoration(
      color: white,
      border: Border.all(color: gray300),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  @override
  afterFirstLayout(BuildContext context) async {
    _startTimer();
    setState(() {
      user = widget.user;
    });
    setState(() {
      isLoadingPage = false;
    });
  }

  checkOpt(value) async {
    try {
      setState(() {
        isLoading = true;
      });
      checkOtp.otpCode = value;
      await AuthApi().otpVerifyMerchant(checkOtp);
      Navigator.of(context).pop(true);
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      pinput.clear();
      print(e.toString());
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  void _startTimer() async {
    if (isSubmit == true) {
      setState(() {
        isGetCode = false;
      });
      _counter = 60;
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
      _counter = 60;
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

  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    final mediaQuery = MediaQuery.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
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
        child: isLoadingPage == true
            ? CustomLoader()
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      translateKey.translate('please_enter_otp_code'),
                      style: TextStyle(
                        color: black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${user.message}',
                      style: TextStyle(
                        color: gray600,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      translateKey.translate('please_enter_otp_code'),
                      style: TextStyle(
                        color: gray800,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 6),
                    Pinput(
                      autofocus: true,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      keyboardType: TextInputType.number,
                      closeKeyboardWhenCompleted: true,
                      // onCompleted: (value) => checkOpt(value),
                      controller: pinput,
                      validator: (value) {
                        if (value == null || value.isEmpty || value == '') {
                          return "Код оруулна уу";
                        }
                        if (value.length < 4) {
                          return "Баталгаажуулах код оруулна уу";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // setState(() {
                        //   validate = false;
                        // });
                      },
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
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isGetCode == false
                            ? Text(
                                '${_counter} ${translateKey.translate('sec')}',
                                style: TextStyle(
                                  color: primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    isSubmit = true;
                                  });
                                  _startTimer();
                                  User data = User();
                                  widget.type == "EMAIL"
                                      ? data.newEmail = widget.userName.trim()
                                      : data.newPhone = widget.userName.trim();
                                  user = user = widget.type == "EMAIL"
                                      ? await ProductApi().putEmail(data)
                                      : await ProductApi().putPhone(data);
                                },
                                child: Text(
                                  translateKey.translate('resend'),
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                      ],
                    ),

                    // FormBuilder(
                    //   key: fbkey,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       FormTextField(
                    //         inputType: TextInputType.text,
                    //         controller: controllerUsername,
                    //         colortext: black,
                    //         name: 'userName',
                    //         color: white,
                    //         suffixIcon: null,
                    //         hintText:
                    //             "${translateKey.translate('phone_number')}, ${translateKey.translate('email')}",
                    //         hintTextColor: gray500,
                    //         labelColor: gray800,
                    //         labelText:
                    //             "${translateKey.translate('login')} ${translateKey.translate('name').toLowerCase()}",
                    //         validator: FormBuilderValidators.compose([
                    //           FormBuilderValidators.required(
                    //             errorText: translateKey.translate(
                    //               'ta_uuriyn_medeelliyg_65b43f00',
                    //             ),
                    //           ),
                    //         ]),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    CustomButton(
                      labelText: translateKey.translate('continue'),
                      onClick: () {
                        if (pinput.text != '' && pinput.text.length == 6) {
                          checkOpt(pinput.text);
                        }
                      },
                      isLoading: isLoading,
                      buttonColor: pinput.text.length < 6
                          ? primary200
                          : primary,
                      textColor: white,
                      buttonLoaderColor: white,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
