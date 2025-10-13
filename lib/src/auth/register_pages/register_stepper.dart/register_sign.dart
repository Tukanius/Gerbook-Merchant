import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_app_bar.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_button.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/terms_of_condition.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_stepper.dart/register_bank.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class RegisterSign extends StatefulWidget {
  static const routeName = "RegisterSign";
  const RegisterSign({super.key});

  @override
  State<RegisterSign> createState() => _RegisterSignState();
}

class _RegisterSignState extends State<RegisterSign> with AfterLayoutMixin {
  bool checkTerm = false;
  bool isLoading = false;
  bool isLoadingPage = true;
  TermsOfCondition contract = TermsOfCondition();
  final signController = SignatureController();
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      contract = await ProductApi().getContract();
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = false;
      });
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
            child: CustomAppBar(),
          ),
          backgroundColor: white,
          body: isLoadingPage == true
              ? CustomLoader()
              : Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   translateKey.translate('hereglegchiyn_medeelel'),
                            //   style: TextStyle(
                            //     color: black,
                            //     fontSize: 24,
                            //     fontWeight: FontWeight.w600,
                            //   ),
                            // ),
                            // SizedBox(height: 4),
                            // Text(
                            //   translateKey.translate(
                            //     'please_enter_your_information_correctly',
                            //   ),
                            //   style: TextStyle(
                            //     color: gray600,
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w400,
                            //   ),
                            // ),
                            // SizedBox(height: 12),
                            HtmlWidget("""${contract.text}"""),
                            SizedBox(height: 32),
                            Text(
                              translateKey.translate('sign_here'),
                              style: TextStyle(
                                color: gray900,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: gray100),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(12),
                                child: Signature(
                                  controller: signController,
                                  width: mediaQuery.size.width,
                                  height: 200,
                                  backgroundColor: white,
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  signController.clear();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: white,
                                  border: Border.all(color: gray300),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/svg/reload.svg'),
                                    SizedBox(width: 12),
                                    Text(
                                      translateKey.translate('clear_all'),
                                      style: TextStyle(
                                        color: gray700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: mediaQuery.padding.bottom + 150),
                          ],
                        ),
                      ),
                    ),
                    !isKeyboardVisible
                        ? Align(
                            alignment: AlignmentGeometry.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.only(
                                bottom: Platform.isIOS
                                    ? MediaQuery.of(context).padding.bottom
                                    : 16,
                                left: 16,
                                right: 16,
                                top: 16,
                              ),
                              color: white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        checkTerm = !checkTerm;
                                      });
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        checkTerm == false
                                            ? SvgPicture.asset(
                                                'assets/svg/checkboxterm.svg',
                                                height: 20,
                                                width: 20,
                                              )
                                            : SvgPicture.asset(
                                                'assets/svg/checkboxterm1.svg',
                                                height: 20,
                                                width: 20,
                                              ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            translateKey.translate(
                                              'eviewed_the_collaboration_agreemen',
                                            ),
                                            style: TextStyle(
                                              color: gray800,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  CustomButton(
                                    labelText: translateKey.translate(
                                      'confirm',
                                    ),
                                    onClick: () {
                                      Navigator.of(
                                        context,
                                      ).pushNamed(RegisterBank.routeName);
                                    },
                                    isLoading: isLoading,
                                    buttonColor: checkTerm == true
                                        ? primary
                                        : primary200,
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
