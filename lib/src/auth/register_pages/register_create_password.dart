import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_app_bar.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_button.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_stepper.dart/register_info.dart';
import 'package:provider/provider.dart';

class RegisterCreatePassword extends StatefulWidget {
  static const routeName = "RegisterCreatePassword";
  const RegisterCreatePassword({super.key});

  @override
  State<RegisterCreatePassword> createState() => _RegisterCreatePasswordState();
}

class _RegisterCreatePasswordState extends State<RegisterCreatePassword> {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  bool isLoading = false;
  Color combinationColor = gray600;
  Color lengthColor = gray600;
  bool isVisible = false;
  bool isVisibleVerify = false;
  void validatePassword(String value) {
    setState(() {
      // Validate combination of characters
      combinationColor =
          RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$').hasMatch(value)
          ? verifyGreen
          : value.isEmpty
          ? gray600
          : errorColor;

      // Validate length
      lengthColor = value.length >= 8
          ? verifyGreen
          : value.isEmpty
          ? gray600
          : errorColor;

      // Validate dictionary or common words (mock validation)
      // dictionaryColor = !RegExp(r'^[a-zA-Z]+$').hasMatch(value) || value.isEmpty
      //     ? verifyGreen
      //     : errorColor;

      // // Validate common words (mock validation)
      // commonWordsColor =
      //     !value.toLowerCase().contains("password") || value.isEmpty
      //         ? verifyGreen
      //         : errorColor;

      // // Validate personal info (mock validation)
      // personalInfoColor =
      //     !value.contains("123") || value.isEmpty ? verifyGreen : errorColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final translateKey = Provider.of<LocalizationProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(
      context,
    );
    return PopScope(
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
                    translateKey.translate('password'),
                    style: TextStyle(
                      color: black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  buildValidationRow(
                    text: translateKey.translate('password_combination'),
                    color: combinationColor,
                  ),
                  buildValidationRow(
                    text: translateKey.translate(
                      'password_combination_character',
                    ),
                    color: lengthColor,
                  ),
                  SizedBox(height: 16),
                  FormBuilder(
                    key: fbkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormTextField(
                          labelText: translateKey.translate('password'),
                          hintText: translateKey.translate(
                            'please_enter_your_password',
                          ),
                          hintTextColor: gray103,
                          color: white,
                          inputType: TextInputType.text,
                          controller: passwordController,
                          name: 'password',
                          colortext: black,
                          obscureText: isVisible,
                          labelColor: gray700,
                          onChanged: (value) {
                            validatePassword(value);
                          },
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: translateKey.translate(
                                'please_enter_your_password',
                              ),
                            ),
                          ]),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: isVisible == false
                                ? Icon(Icons.visibility, color: black)
                                : Icon(Icons.visibility_off, color: black),
                          ),
                        ),
                        SizedBox(height: 6),
                        FormTextField(
                          labelText: translateKey.translate(
                            'verify_your_password',
                          ),
                          hintText: translateKey.translate(
                            'please_verify_your_password',
                          ),
                          hintTextColor: gray103,
                          labelColor: gray700,
                          color: white,
                          inputType: TextInputType.text,
                          controller: newPasswordController,
                          name: 'oldPassword11',
                          colortext: black,
                          obscureText: isVisibleVerify,
                          validators: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: translateKey.translate(
                                'please_verify_your_password',
                              ),
                            ),
                            (value) {
                              if (fbkey
                                      .currentState
                                      ?.fields['password']
                                      ?.value !=
                                  value) {
                                return translateKey.translate(
                                  'password_not_match',
                                );
                              }
                              return null;
                            },
                          ]),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisibleVerify = !isVisibleVerify;
                              });
                            },
                            icon: isVisibleVerify == false
                                ? Icon(Icons.visibility, color: black)
                                : Icon(Icons.visibility_off, color: black),
                          ),
                        ),
                        // FormTextField(
                        //   inputType: TextInputType.text,
                        //   controller: controllerUsername,
                        //   colortext: black,
                        //   name: 'userName',
                        //   color: white,
                        //   suffixIcon: null,
                        //   hintText:
                        //       "${translateKey.translate('phone_number')}, ${translateKey.translate('email')}",
                        //   hintTextColor: gray500,
                        //   labelColor: gray800,
                        //   labelText:
                        //       "${translateKey.translate('login')} ${translateKey.translate('name').toLowerCase()}",
                        //   validator: FormBuilderValidators.compose([
                        //     FormBuilderValidators.required(
                        //       errorText: translateKey.translate(
                        //         'ta_uuriyn_medeelliyg_65b43f00',
                        //       ),
                        //     ),
                        //   ]),
                        // ),
                      ],
                    ),
                  ),
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
                              ).pushNamed(RegisterInfo.routeName);
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
    );
  }

  Widget buildValidationRow({required String text, required Color color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('•', style: TextStyle(fontSize: 14, color: color)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: color,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
