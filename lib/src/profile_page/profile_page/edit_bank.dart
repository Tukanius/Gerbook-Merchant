import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:merchant_gerbook_flutter/api/auth_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class EditBank extends StatefulWidget {
  const EditBank({super.key});

  @override
  State<EditBank> createState() => _EditBankState();
}

class _EditBankState extends State<EditBank> with AfterLayoutMixin {
  bool isLoadingButton = false;
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  TextEditingController bank = TextEditingController();
  TextEditingController bankAccount = TextEditingController();
  TextEditingController bankAccountName = TextEditingController();

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
      bank.text = user.bank ?? '';
      bankAccount.text = user.bankAccount ?? '';
      bankAccountName.text = user.bankAccountName ?? '';
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
        User save = User.fromJson(fbkey.currentState!.value);
        save.bank = bank.text;
        save.bankAccount = bankAccount.text;
        save.bankAccountName = bankAccountName.text;

        user = await AuthApi().postBankAccount(save);
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
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 24),
                FormBuilder(
                  key: fbkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormTextField(
                          inputType: TextInputType.text,
                          controller: bank,
                          colortext: black,
                          name: 'bank',
                          color: white,
                          suffixIcon: null,
                          hintText:
                              "${translateKey.translate('please_enter_your_bank')}",
                          hintTextColor: gray500,
                          labelColor: gray700,
                          labelText: "${translateKey.translate('bank')}",
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: translateKey.translate(
                                'ta_uuriyn_medeelliyg_65b43f00',
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(height: 6),
                        FormTextField(
                          inputType: TextInputType.text,
                          controller: bankAccount,
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
                                'ta_uuriyn_medeelliyg_65b43f00',
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(height: 6),
                        FormTextField(
                          inputType: TextInputType.text,
                          controller: bankAccountName,
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
                    SizedBox(width: 16),
                  ],
                ),
                SizedBox(height: mediaQuery.padding.bottom + 16),
              ],
            ),
    );
  }
}
