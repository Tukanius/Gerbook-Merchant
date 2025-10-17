import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_app_bar.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_button.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/provider/user_provider.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_otp_page.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "RegisterPage";
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  TextEditingController controllerUsername = TextEditingController();
  bool isLoading = false;

  onSubmit() async {
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        FocusScope.of(context).unfocus();
        User save = User.fromJson(fbkey.currentState!.value);
        await Provider.of<UserProvider>(
          context,
          listen: false,
        ).registerEmailMerchant(save);
        Navigator.of(context).pushNamed(
          RegisterOtpPage.routeName,
          arguments: RegisterOtpPageArguments(
            email: save.email!,
            method: 'REGISTER',
          ),
        );
        setState(() {
          isLoading = false;
        });
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
                Navigator.of(context).pop();
              },
            ),
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
                      translateKey.translate('sign_up'),
                      style: TextStyle(
                        color: black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      translateKey.translate('register_description'),
                      style: TextStyle(
                        color: gray600,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 16),
                    FormBuilder(
                      key: fbkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormTextField(
                            inputType: TextInputType.text,
                            controller: controllerUsername,
                            colortext: black,
                            name: 'email',
                            color: white,
                            suffixIcon: null,
                            hintText:
                                "${translateKey.translate('please_enter_your_email')}",
                            hintTextColor: gray500,
                            labelColor: gray800,
                            labelText: "${translateKey.translate('email')} ",
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
                              labelText: translateKey.translate('get_otp'),
                              onClick: () {
                                onSubmit();
                              },
                              isLoading: isLoading,
                              buttonColor: primary,
                              textColor: white,
                              buttonLoaderColor: white,
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: mediaQuery.size.width,
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Wrap(
                                runAlignment: WrapAlignment.center,
                                alignment: WrapAlignment.center,
                                children: [
                                  Text(
                                    "${translateKey.translate('have_an_account')} ",
                                    style: TextStyle(
                                      color: gray800,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      translateKey.translate('login'),
                                      style: TextStyle(
                                        color: gray800,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),

                            // Text(
                            //   translateKey.translate('register_description'),
                            //   style: TextStyle(
                            //     color: gray600,
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
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
