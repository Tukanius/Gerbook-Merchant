import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:merchant_gerbook_flutter/api/auth_api.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/src/auth/login_page.dart';
// import 'package:merchant_gerbook_flutter/src/auth/login_page.dart';
import 'package:merchant_gerbook_flutter/src/auth/onboarding_page.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_stepper.dart/register_bank.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_stepper.dart/register_info.dart';
import 'package:merchant_gerbook_flutter/src/auth/register_pages/register_stepper.dart/register_sign.dart';
import 'package:merchant_gerbook_flutter/src/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class SplashPage extends StatefulWidget {
  final bool seenPage;
  static const routeName = "SplashPage";
  const SplashPage({super.key, required this.seenPage});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin {
  User user = User();

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    bool isShow = await prefs.getBool('seenOnboarding') ?? false;

    try {
      if (isShow == false) {
        Navigator.of(context).pushNamed(OnboardingPage.routeName);
      } else {
        user = await AuthApi().me(false);
        print('===test====');
        print(user.firstName);
        print(user.contract);
        print(user.bank);
        print(user.bankAccount);
        print(user.bankAccountName);
        print(user.merchantType);
        print('===test====');

        if (user.firstName == null) {
          await Navigator.of(context).pushNamed(RegisterInfo.routeName);
        } else if (user.contract == null) {
          await Navigator.of(context).pushNamed(RegisterSign.routeName);
        } else if (user.bank == null) {
          await Navigator.of(context).pushNamed(RegisterBank.routeName);
        } else {
          await Navigator.of(context).pushNamed(
            MainPage.routeName,
            arguments: MainPageArguments(changeIndex: 0),
          );
        }

        // if (user.userStatus == "OTP_VERIFIED" ||
        //     user.userStatus == "VERIFIED") {}
      }
    } catch (e) {
      await Navigator.of(context).pushNamed(LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Center(
        child: Container(
          width: 178,
          height: 90,
          child: Image.asset('assets/images/splash.png'),
        ),
      ),
    );
  }
}
