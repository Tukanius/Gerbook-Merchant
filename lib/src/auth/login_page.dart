// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/custom_button.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/provider/user_provider.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_page.dart';
import 'package:merchant_gerbook_flutter/src/splash_page/splash_page.dart';
import 'package:merchant_gerbook_flutter/utils/secure_storage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "LoginPage";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AfterLayoutMixin {
  bool isVisible = true;
  bool saveUserName = false;
  GlobalKey<FormBuilderState> fbkey = GlobalKey<FormBuilderState>();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  final SecureStorage secureStorage = SecureStorage();
  bool isLoading = false;
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    Future<String?> usernameStore = secureStorage.getUserName();
    String resultUsername = await usernameStore ?? "";
    print('=============STORED==========');
    print(resultUsername);
    print('=============STORED==========');
    if (resultUsername != "") {
      setState(() {
        controllerPhone.text = resultUsername;
        saveUserName = true;
      });
    }
  }

  onSubmit() async {
    FocusScope.of(context).unfocus();
    if (fbkey.currentState!.saveAndValidate()) {
      try {
        setState(() {
          isLoading = true;
        });
        String input =
            fbkey.currentState?.fields['username']?.value.toString().trim() ??
            '';

        // 📌 Email эсвэл Phone эсэхийг шалгах
        bool isEmail = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(input);
        bool isPhone = RegExp(r'^\d+$').hasMatch(input);

        // 📌 Model-д тохируулж өгөгдөл бэлдэх
        User save = User(
          email: isEmail ? input : null,
          phone: isPhone ? input : null,
          password: fbkey.currentState?.fields['password']?.value,
        );

        // Хэрэглэгчийн нэрийг хадгалах тохиргоо
        if (saveUserName) {
          _storeUserName(input);
        } else {
          secureStorage.deleteAll();
        }

        await Provider.of<UserProvider>(context, listen: false).login(save);
        await UserProvider().setUsername(save.userName.toString());
        await Provider.of<UserProvider>(context, listen: false).me(true);

        setState(() {
          isLoading = false;
        });
        await Navigator.of(context).pushNamed(SplashPage.routeName);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e.toString());
      }
    }
  }

  _storeUserName(String userName) async {
    await secureStorage.setUserName(userName);
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
          resizeToAvoidBottomInset: false,
          body: Container(
            height: mediaQuery.size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    SizedBox(height: mediaQuery.padding.top + 42),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          height: 122,
                          child: Image.asset(
                            'assets/images/login_logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: BlurryContainer(
                    blur: 2,
                    padding: EdgeInsets.all(0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [black, black.withOpacity(0.2)],
                        ),

                        border: Border(top: BorderSide(color: gray400)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Row(
                            children: [
                              SizedBox(width: 16),
                              Text(
                                translateKey.translate('login'),
                                style: TextStyle(
                                  color: white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          FormBuilder(
                            key: fbkey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormTextField(
                                    inputType: TextInputType.text,
                                    controller: controllerPhone,
                                    colortext: black,
                                    name: 'username',
                                    color: white,
                                    suffixIcon: null,
                                    hintText:
                                        "${translateKey.translate('phone_number')}, ${translateKey.translate('email')}",
                                    hintTextColor: gray500,
                                    onChanged: (value) {
                                      secureStorage.deleteAll();
                                    },
                                    labelColor: white,
                                    labelText:
                                        "${translateKey.translate('phone')} / ${translateKey.translate('email')}",
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
                                    labelText: translateKey.translate(
                                      'password',
                                    ),
                                    labelColor: white,
                                    hintText: translateKey.translate(
                                      'please_enter_your_password',
                                    ),
                                    hintTextColor: gray500,
                                    color: white,
                                    inputType: TextInputType.text,
                                    controller: controllerPassword,
                                    name: 'password',
                                    colortext: black,
                                    obscureText: isVisible,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      icon: isVisible == false
                                          ? Icon(Icons.visibility, color: black)
                                          : Icon(
                                              Icons.visibility_off,
                                              color: black,
                                            ),
                                    ),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        errorText: translateKey.translate(
                                          'please_enter_your_password',
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      saveUserName = !saveUserName;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 16,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          color: white,
                                          border: BoxBorder.all(
                                            color: saveUserName == true
                                                ? primary
                                                : white,
                                          ),
                                        ),
                                        child: saveUserName == true
                                            ? Padding(
                                                padding: const EdgeInsets.all(
                                                  2.0,
                                                ),
                                                child: SvgPicture.asset(
                                                  'assets/svg/check.svg',
                                                ),
                                              )
                                            : SizedBox(),
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        translateKey.translate('remember_me'),
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      RegisterPage.routeName,
                                      arguments: RegisterPageArguments(
                                        isRegister: false,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    translateKey.translate('forgot_password'),
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomButton(
                              buttonLoaderColor: white,
                              labelText: translateKey.translate('login'),
                              onClick: () {
                                onSubmit();
                                // _completeOnboarding(context);
                              },
                              buttonColor: primary,
                              isLoading: isLoading,
                              textColor: white,
                            ),
                          ),
                          SizedBox(height: 16),
                          !isKeyboardVisible
                              ? Column(
                                  children: [
                                    Container(
                                      width: mediaQuery.size.width,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Wrap(
                                        runAlignment: WrapAlignment.center,
                                        alignment: WrapAlignment.center,
                                        children: [
                                          Text(
                                            "${translateKey.translate('dont_have_an_account')}? ",
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                RegisterPage.routeName,
                                                arguments:
                                                    RegisterPageArguments(
                                                      isRegister: true,
                                                    ),
                                              );
                                            },
                                            child: Text(
                                              translateKey.translate(
                                                'create_account',
                                              ),
                                              style: TextStyle(
                                                color: white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    // Row(
                                    //   children: [
                                    //     SizedBox(width: 16),
                                    //     Expanded(
                                    //       child: Container(
                                    //         height: 1,
                                    //         color: white,
                                    //       ),
                                    //     ),
                                    //     SizedBox(width: 12),
                                    //     Text(
                                    //       translateKey.translate('or'),
                                    //       style: TextStyle(
                                    //         color: white,
                                    //         fontSize: 14,
                                    //         fontWeight: FontWeight.w600,
                                    //       ),
                                    //     ),
                                    //     SizedBox(width: 12),
                                    //     Expanded(
                                    //       child: Container(
                                    //         height: 1,
                                    //         color: white,
                                    //       ),
                                    //     ),
                                    //     SizedBox(width: 16),
                                    //   ],
                                    // ),
                                    // SizedBox(height: 16),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.center,
                                    //   children: [
                                    //     Container(
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(
                                    //           12,
                                    //         ),
                                    //         color: white,
                                    //         border: Border.all(color: gray300),
                                    //       ),
                                    //       padding: EdgeInsets.symmetric(
                                    //         vertical: 10,
                                    //         horizontal: 12,
                                    //       ),
                                    //       child: SvgPicture.asset(
                                    //         'assets/svg/google.svg',
                                    //       ),
                                    //     ),
                                    //     SizedBox(width: 16),
                                    //     Container(
                                    //       decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(
                                    //           12,
                                    //         ),
                                    //         color: black,
                                    //         border: Border.all(color: black),
                                    //       ),
                                    //       padding: EdgeInsets.symmetric(
                                    //         vertical: 10,
                                    //         horizontal: 12,
                                    //       ),
                                    //       child: SvgPicture.asset(
                                    //         'assets/svg/apple.svg',
                                    //         color: white,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(height: mediaQuery.padding.bottom + 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
