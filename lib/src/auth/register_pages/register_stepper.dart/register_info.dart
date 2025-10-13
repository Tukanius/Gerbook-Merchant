import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_app_bar.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_button.dart';
import 'package:merchant_gerbook_flutter/components/register-number/letter.dart';
import 'package:merchant_gerbook_flutter/components/register-number/letters.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_stepper.dart/register_sign.dart';
import 'package:merchant_gerbook_flutter/utils/is_device_size.dart';
import 'package:provider/provider.dart';

class RegisterInfo extends StatefulWidget {
  static const routeName = "RegisterInfo";
  const RegisterInfo({super.key});

  @override
  State<RegisterInfo> createState() => _RegisterInfoState();
}

class _RegisterInfoState extends State<RegisterInfo> {
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
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: gray100,
                        border: Border.all(color: gray200),
                      ),
                      padding: EdgeInsets.all(2),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  registerIndex = 0;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: registerIndex == 0 ? white : gray100,
                                ),
                                padding: EdgeInsets.all(6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${translateKey.translate('individual')}',
                                        style: TextStyle(
                                          color: gray800,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  registerIndex = 1;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: registerIndex == 1 ? white : gray100,
                                ),
                                padding: EdgeInsets.all(6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${translateKey.translate('institution')}',
                                        style: TextStyle(
                                          color: gray800,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
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
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: gray200),
                            color: white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: SvgPicture.asset(
                              'assets/svg/add_profile.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    registerIndex == 0
                        ? FormBuilder(
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

                                Text(
                                  translateKey.translate('registration_number'),
                                  style: TextStyle(
                                    color: gray700,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 6),
                                FormBuilderField(
                                  autovalidateMode: AutovalidateMode.disabled,
                                  name: "registerNo",
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText:
                                          '${translateKey.translate('ta_uuriyn_medeelliyg_65b43f00')}',
                                    ),
                                    (dynamic value) => value.toString() != ""
                                        ? (validateStructure(
                                                letters.join(),
                                                value.toString(),
                                              )
                                              ? null
                                              : "${translateKey.translate('ta_uuriyn_medeelliyg_65b43f00')}")
                                        : null,
                                  ]),
                                  builder: (FormFieldState<dynamic> field) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        errorText: field.errorText,
                                        fillColor: white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: const EdgeInsets.all(0),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 0.0,
                                              ),
                                            ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            RegisterLetters(
                                              width: DeviceSize.width(
                                                3,
                                                context,
                                              ),
                                              height: DeviceSize.height(
                                                90,
                                                context,
                                              ),
                                              hideOnPressed: false,
                                              title: letters[0],
                                              oneTitle: translateKey.translate(
                                                'registration_number',
                                              ),
                                              textColor: gray800,
                                              length: CYRILLIC_ALPHABETS_LIST
                                                  .length,
                                              itemBuilder: (ctx, i) => RegisterLetter(
                                                text:
                                                    CYRILLIC_ALPHABETS_LIST[i],
                                                onPressed: () {
                                                  onChangeLetter(
                                                    CYRILLIC_ALPHABETS_LIST[i],
                                                    0,
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            RegisterLetters(
                                              width: DeviceSize.width(
                                                3,
                                                context,
                                              ),
                                              height: DeviceSize.height(
                                                90,
                                                context,
                                              ),
                                              title: letters[1],
                                              hideOnPressed: false,
                                              textColor: gray800,
                                              length: CYRILLIC_ALPHABETS_LIST
                                                  .length,
                                              oneTitle: translateKey.translate(
                                                'registration_number',
                                              ),
                                              itemBuilder: (ctx, i) => RegisterLetter(
                                                text:
                                                    CYRILLIC_ALPHABETS_LIST[i],
                                                onPressed: () {
                                                  onChangeLetter(
                                                    CYRILLIC_ALPHABETS_LIST[i],
                                                    1,
                                                  );
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Expanded(
                                              child: FormTextField(
                                                maxLenght: 8,
                                                showCounter: false,
                                                inputType: TextInputType.number,
                                                colortext: black,
                                                hintTextColor: gray500,
                                                color: white,
                                                onChanged: (value) {
                                                  setState(() {
                                                    registerNo = value!;
                                                  });
                                                  // ignore: invalid_use_of_protected_member
                                                  field.setValue(value);
                                                },
                                                // fi: true,
                                                // fillColor: white,
                                                controller: regnumController,
                                                name: 'registerNumber',
                                                hintText:
                                                    '${translateKey.translate('registration_number')}',
                                                inputFormatters:
                                                    <TextInputFormatter>[
                                                      FilteringTextInputFormatter.allow(
                                                        RegExp(r'[0-9]'),
                                                      ),
                                                    ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        : FormBuilder(
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
                              ],
                            ),
                          ),

                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(12),
                    //     border: Border.all(color: gray200),
                    //     color: white,
                    //   ),
                    //   child: Column(
                    //     children: [
                    //       SizedBox(height: 140),
                    //       Center(
                    //         child: SvgPicture.asset(
                    //           'assets/svg/add_profile.svg',
                    //         ),
                    //       ),
                    //       SizedBox(height: 140),
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
                                ).pushNamed(RegisterSign.routeName);
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
