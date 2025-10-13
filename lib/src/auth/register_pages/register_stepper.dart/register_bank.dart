import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_app_bar.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_button.dart';
import 'package:merchant_gerbook_flutter/components/register-number/letters.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/main_page.dart';
import 'package:provider/provider.dart';

class RegisterBank extends StatefulWidget {
  static const routeName = "RegisterBank";
  const RegisterBank({super.key});

  @override
  State<RegisterBank> createState() => _RegisterBankState();
}

class _RegisterBankState extends State<RegisterBank> {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int registerIndex = 0;
  bool isLoading = false;
  TextEditingController regnumController = TextEditingController();
  List<String> letters = [
    CYRILLIC_ALPHABETS_LIST[0],
    CYRILLIC_ALPHABETS_LIST[0],
  ];
  String registerNo = "";
  void onChangeLetter(String item, index) {
    Navigator.pop(context);

    setState(() {
      letters[index] = item;
    });
  }

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
                      translateKey.translate('hereglegchiyn_medeelel'),
                      style: TextStyle(
                        color: black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      translateKey.translate(
                        'please_enter_your_information_correctly',
                      ),
                      style: TextStyle(
                        color: gray600,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 12),
                    FormBuilder(
                      key: fbkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormTextField(
                            inputType: TextInputType.text,
                            controller: lastNameController,
                            colortext: black,
                            name: 'lastName',
                            color: white,
                            suffixIcon: null,
                            hintText:
                                "${translateKey.translate('phone_number')}, ${translateKey.translate('email')}",
                            hintTextColor: gray700,

                            labelColor: gray700,
                            labelText:
                                "${translateKey.translate('login')} ${translateKey.translate('name').toLowerCase()}",
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: translateKey.translate(
                                  'ta_uuriyn_medeelliyg_65b43f00',
                                ),
                              ),
                            ]),
                          ),
                          SizedBox(height: 12),
                          FormTextField(
                            inputType: TextInputType.text,
                            controller: firstNameController,
                            colortext: black,
                            name: 'firstName',
                            color: white,
                            suffixIcon: null,
                            hintText:
                                "${translateKey.translate('phone_number')}, ${translateKey.translate('email')}",
                            hintTextColor: gray500,
                            labelColor: gray700,
                            labelText:
                                "${translateKey.translate('login')} ${translateKey.translate('name').toLowerCase()}",
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: translateKey.translate(
                                  'ta_uuriyn_medeelliyg_65b43f00',
                                ),
                              ),
                            ]),
                          ),
                          SizedBox(height: 12),
                          FormTextField(
                            inputType: TextInputType.text,
                            controller: firstNameController,
                            colortext: black,
                            name: 'bank',
                            color: white,
                            suffixIcon: null,
                            hintText:
                                "${translateKey.translate('phone_number')}, ${translateKey.translate('email')}",
                            hintTextColor: gray500,
                            labelColor: gray700,
                            labelText:
                                "${translateKey.translate('login')} ${translateKey.translate('name').toLowerCase()}",
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
                              labelText: translateKey.translate('save'),
                              onClick: () {
                                Navigator.of(context).pushNamed(
                                  MainPage.routeName,
                                  arguments: MainPageArguments(changeIndex: 0),
                                );
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

bool validateStructure(String value, String number) {
  if (number.length < 8) return false;
  if (isNumeric(number)) {
    return true;
  }
  return true;
}

bool isNumeric(String s) {
  if (s.isEmpty) {
    return false;
  }

  return !int.parse(s).isNaN;
}
