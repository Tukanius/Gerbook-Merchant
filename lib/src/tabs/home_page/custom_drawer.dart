// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/api/auth_api.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/avatar_upload.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/provider/user_provider.dart';
import 'package:merchant_gerbook_flutter/src/localization/change_language.dart';
import 'package:merchant_gerbook_flutter/src/localization/localization_local.dart';
import 'package:merchant_gerbook_flutter/src/splash_page/splash_page.dart';
import 'package:merchant_gerbook_flutter/src/profile_page/profile_page/profile.dart';
import 'package:merchant_gerbook_flutter/src/tabs/dashboard_page/transaction_list_page.dart';
import 'package:provider/provider.dart';
import 'package:merchant_gerbook_flutter/src/profile_page/settings_page/settings_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> with AfterLayoutMixin {
  String? myLanguage;

  User user = User();
  bool isLoading = true;
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await getLocaleData();
    try {
      user = await AuthApi().me(false);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = true;
      });
    }
  }

  getLocaleData() async {
    myLanguage = await getLocale();
    if (myLanguage == null) {
      await saveLocale('mn');
      myLanguage = await getLocale();
    } else {
      myLanguage = await getLocale();
    }
  }

  toExit() {
    final local = Provider.of<LocalizationProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: white,
          title: Center(
            child: Text(
              local.translate('logout'),
              style: TextStyle(
                color: black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          content: Text(
            local.translate('wanna_log_out'),
            style: TextStyle(color: black, fontSize: 16),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          actionsAlignment: MainAxisAlignment.end,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                local.translate('cancel'),
                style: TextStyle(color: black),
              ),
            ),
            TextButton(
              onPressed: () async {
                await onExit(context);
                // Navigator.of(context).pop();
              },
              child: Text(
                local.translate('logout'),
                style: TextStyle(color: black),
              ),
            ),
          ],
        );
      },
    );
  }

  onExit(BuildContext dialogContext) async {
    try {
      await Provider.of<UserProvider>(context, listen: false).logout();
      Navigator.of(dialogContext).pop();
      Navigator.of(context).pushNamed(SplashPage.routeName);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Container(
      color: white,
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).popAndPushNamed(ProfilePage.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: AlignmentGeometry.bottomCenter,
                      end: AlignmentGeometry.topRight,
                      tileMode: TileMode.clamp,
                      colors: [primary, primaryDrawer],
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: mediaQuery.padding.top + 16),
                      Row(
                        children: [
                          SizedBox(width: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: user.avatar != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: BlurHash(
                                        color: gray100,
                                        hash:
                                            '${(user.avatar as Avatar).blurhash}',
                                        image: '${(user.avatar as Avatar).url}',
                                        imageFit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: gray100,
                                    ),
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/svg/user_photo.svg',
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                  ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${user.firstName ?? ''} ${user.lastName ?? ''}',
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${user.email ?? ''}',
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/chevron_right.svg',
                                      height: 20,
                                      width: 20,
                                      color: white,
                                    ),
                                    SizedBox(width: 16),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(
                    context,
                  ).popAndPushNamed(TransactionListPage.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: gray200)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/cash.svg'),
                            SizedBox(width: 10),
                            Text(
                              translateKey.translate('transactions'),
                              style: TextStyle(
                                color: gray800,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          'assets/svg/chevron_right.svg',
                          height: 20,
                          width: 20,
                          color: gray800,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).popAndPushNamed(SettingsPage.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: gray200)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/settings.svg'),
                            SizedBox(width: 10),
                            Text(
                              translateKey.translate('settings'),
                              style: TextStyle(
                                color: gray800,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          'assets/svg/chevron_right.svg',
                          height: 20,
                          width: 20,
                          color: gray800,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  final value = await Navigator.of(
                    context,
                  ).pushNamed(ChangeLanguagePage.routeName);
                  if (value == true) {
                    await getLocaleData();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: gray200)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              myLanguage == 'mn'
                                  ? 'assets/svg/mn.svg'
                                  : myLanguage == 'en'
                                  ? 'assets/svg/uk.svg'
                                  : myLanguage == 'zh'
                                  ? 'assets/svg/china.svg'
                                  : myLanguage == 'ko'
                                  ? 'assets/svg/korea.svg'
                                  : myLanguage == 'ja'
                                  ? 'assets/svg/jpn.svg'
                                  : myLanguage == 'ru'
                                  ? 'assets/svg/circle_ru.svg'
                                  : myLanguage == 'de'
                                  ? 'assets/svg/circle_german.svg'
                                  : 'assets/svg/mn.svg',
                              width: 18,
                              height: 18,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  translateKey.translate('change_language'),
                                  style: TextStyle(
                                    color: gray800,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  translateKey.translate('transactions'),
                                  style: TextStyle(
                                    color: gray600,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                          'assets/svg/chevron_right.svg',
                          height: 20,
                          width: 20,
                          color: gray800,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              toExit();
            },
            child: Padding(
              padding: EdgeInsets.only(
                bottom: Platform.isIOS
                    ? mediaQuery.padding.bottom
                    : mediaQuery.padding.bottom + 16,
                right: 16,
                left: 16,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: white,
                  border: Border.all(color: gray300),
                ),
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/svg/log_out.svg'),
                    SizedBox(width: 8),
                    Text(
                      translateKey.translate('logout'),
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
          ),
        ],
      ),
    );
  }
}
