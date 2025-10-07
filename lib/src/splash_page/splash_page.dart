import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/src/auth/login_page.dart';
// import 'package:merchant_gerbook_flutter/src/auth/login_page.dart';
import 'package:merchant_gerbook_flutter/src/auth/onboarding_page.dart';
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
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    bool isShow = await prefs.getBool('seenOnboarding') ?? false;

    Future.delayed(const Duration(seconds: 1), () {
      isShow == false
          ? Navigator.of(context).pushNamed(OnboardingPage.routeName)
          : Navigator.of(context).pushNamed(LoginPage.routeName);
    });
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
