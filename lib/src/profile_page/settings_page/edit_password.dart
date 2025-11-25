import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:merchant_gerbook_flutter/api/auth_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> with AfterLayoutMixin {
  bool isLoadingButton = false;

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
      user = await AuthApi().me(false);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  TextEditingController current = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController confirm = TextEditingController();

  bool isVisible = true;
  bool isVisible1 = true;
  bool isVisible2 = true;

  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoadingButton = true;
        });
        User save = User.fromJson(fbkey.currentState!.value);
        await AuthApi().changeUserPassword(save);

        setState(() {
          isLoadingButton = false;
        });
        Navigator.of(context).pop();
        // showSuccessDialog(context, local.translate('password_change_success'));
      } catch (e) {
        setState(() {
          isLoadingButton = false;
        });
        print(e.toString());
      }
    }
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
      child: isLoadingPage == true
          ? SizedBox(height: 200, child: CustomLoader(loadColor: primary))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 24),
                  FormBuilder(
                    key: fbkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormTextField(
                          inputType: TextInputType.text,
                          controller: current,
                          colortext: black,
                          name: 'oldPassword',
                          color: white,
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
                          obscureText: isVisible,
                          hintText: translateKey.translate('current_password'),
                          hintTextColor: gray103,
                          onChanged: (value) {},
                          labelText: translateKey.translate('current_password'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: translateKey.translate(
                                'enter_current_password',
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(height: 15),
                        FormTextField(
                          inputType: TextInputType.text,
                          controller: newPass,
                          colortext: black,
                          name: 'password',
                          color: white,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible1 = !isVisible1;
                              });
                            },
                            icon: isVisible1 == false
                                ? Icon(Icons.visibility, color: black)
                                : Icon(Icons.visibility_off, color: black),
                          ),
                          obscureText: isVisible1,
                          hintText: translateKey.translate('new_password'),
                          hintTextColor: gray103,
                          onChanged: (value) {},
                          labelText: translateKey.translate('new_password'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: translateKey.translate(
                                'please_enter_your_new_password',
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(height: 15),
                        FormTextField(
                          inputType: TextInputType.text,
                          controller: confirm,
                          colortext: black,
                          name: 'Confirm password',
                          color: white,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible2 = !isVisible2;
                              });
                            },
                            icon: isVisible2 == false
                                ? Icon(Icons.visibility, color: black)
                                : Icon(Icons.visibility_off, color: black),
                          ),
                          obscureText: isVisible2,
                          hintText: translateKey.translate('confirm_password'),
                          hintTextColor: gray103,
                          onChanged: (value) {},
                          labelText: translateKey.translate('confirm_password'),
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
                        ),
                      ],
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
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
                    ],
                  ),
                  SizedBox(height: mediaQuery.padding.bottom + 16),
                ],
              ),
            ),
    );
  }
}
