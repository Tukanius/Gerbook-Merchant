import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:merchant_gerbook_flutter/api/auth_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_app_bar.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_button.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/register-number/letters.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_stepper.dart/register_sign.dart';
import 'package:merchant_gerbook_flutter/src/splash_page/splash_page.dart';
import 'package:provider/provider.dart';

class RegisterBank extends StatefulWidget {
  static const routeName = "RegisterBank";
  const RegisterBank({super.key});

  @override
  State<RegisterBank> createState() => _RegisterBankState();
}

class _RegisterBankState extends State<RegisterBank> with AfterLayoutMixin {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  TextEditingController bankCont = TextEditingController();
  TextEditingController bankAccountCont = TextEditingController();
  TextEditingController bankAccountNameCont = TextEditingController();
  int registerIndex = 0;
  bool isLoading = false;
  bool isLoadingPage = true;
  TextEditingController regnumController = TextEditingController();
  List<String> letters = [
    CYRILLIC_ALPHABETS_LIST[0],
    CYRILLIC_ALPHABETS_LIST[0],
  ];
  String registerNo = "";
  User user = User();
  void onChangeLetter(String item, index) {
    Navigator.pop(context);

    setState(() {
      letters[index] = item;
    });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      user = await AuthApi().me(false);
      bankCont.text = user.bank ?? '';
      bankAccountCont.text = user.bankAccount ?? '';
      bankAccountNameCont.text = user.bankAccountName ?? '';
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = false;
      });
    }
  }

  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        print('========');
        print(fbkey.currentState?.value["bank"]);
        print(fbkey.currentState?.value["bankAccount"]);
        print(fbkey.currentState?.value["bankAccountName"]);
        print('========');

        User save = User.fromJson(fbkey.currentState!.value);
        save.bank = bankCont.text;
        save.bankAccount = bankAccountCont.text;
        save.bankAccountName = bankAccountNameCont.text;

        user = await AuthApi().postBankAccount(save);
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushNamed(SplashPage.routeName);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
      }
    }
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
            child: CustomAppBar(
              onTap: () {
                Navigator.of(context).pushNamed(RegisterSign.routeName);
              },
            ),
          ),
          backgroundColor: white,
          body: isLoadingPage == true
              ? CustomLoader()
              : Stack(
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
                                  controller: bankCont,
                                  colortext: black,
                                  name: 'bank',
                                  color: white,
                                  suffixIcon: null,
                                  hintText:
                                      "${translateKey.translate('please_enter_your_bank')}",
                                  hintTextColor: gray700,
                                  labelColor: gray700,
                                  labelText:
                                      "${translateKey.translate('bank')}",
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText: translateKey.translate(
                                        'this_field_is_required',
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox(height: 12),
                                FormTextField(
                                  inputType: TextInputType.text,
                                  controller: bankAccountCont,
                                  colortext: black,
                                  name: 'bankAccount',
                                  color: white,
                                  suffixIcon: null,
                                  hintText:
                                      "${translateKey.translate('please_enter_your_bank_account_number')}",
                                  hintTextColor: gray500,
                                  labelColor: gray700,
                                  labelText:
                                      "${translateKey.translate('bank_account_number')}",
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText: translateKey.translate(
                                        'this_field_is_required',
                                      ),
                                    ),
                                  ]),
                                ),
                                SizedBox(height: 12),
                                FormTextField(
                                  inputType: TextInputType.text,
                                  controller: bankAccountNameCont,
                                  colortext: black,
                                  name: 'bankAccountName',
                                  color: white,
                                  suffixIcon: null,
                                  hintText:
                                      "${translateKey.translate('please_enter_your_bank_account_holder_name')}",
                                  hintTextColor: gray500,
                                  labelColor: gray700,
                                  labelText:
                                      "${translateKey.translate('bank_account_holder_name')}",
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText: translateKey.translate(
                                        'this_field_is_required',
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                children: [
                                  CustomButton(
                                    labelText: translateKey.translate('save'),
                                    onClick: () {
                                      onSubmit();
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
