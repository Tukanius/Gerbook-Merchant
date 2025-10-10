import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_app_bar.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_button.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_create_password.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class RegisterOtpPage extends StatefulWidget {
  static const routeName = 'RegisterOtpPage';
  const RegisterOtpPage({super.key});

  @override
  State<RegisterOtpPage> createState() => _RegisterOtpPageState();
}

class _RegisterOtpPageState extends State<RegisterOtpPage> {
  TextEditingController pinput = TextEditingController();

  bool isLoading = false;
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
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(
      context,
    );
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(),
          ),
          backgroundColor: white,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      // '${user.}'
                      'user.message',
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
                        Text(
                          translateKey.translate('resend'),
                          style: TextStyle(
                            color: primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
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
                  ],
                ),
              ),
              !isKeyboardVisible
                  ? Positioned(
                      bottom: Platform.isIOS
                          ? mediaQuery.padding.bottom
                          : mediaQuery.padding.bottom + 16,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            CustomButton(
                              labelText: translateKey.translate('continue'),
                              onClick: () {
                                Navigator.of(
                                  context,
                                ).pushNamed(RegisterCreatePassword.routeName);
                              },
                              isLoading: isLoading,
                              buttonColor: primary,
                              textColor: white,
                              buttonLoaderColor: white,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
