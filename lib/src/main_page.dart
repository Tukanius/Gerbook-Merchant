import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/add_ger_page.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp.dart';
import 'package:merchant_gerbook_flutter/src/tabs/dashboard_page/dashboard_page.dart';
import 'package:merchant_gerbook_flutter/src/tabs/ger_page/ger_page.dart';
import 'package:merchant_gerbook_flutter/src/tabs/home_page/custom_drawer.dart';
import 'package:merchant_gerbook_flutter/src/tabs/home_page/home_page.dart';
import 'package:merchant_gerbook_flutter/src/tabs/order_page/order_page.dart';
import 'package:provider/provider.dart';

class MainPageArguments {
  final int changeIndex;
  MainPageArguments({required this.changeIndex});
}

class MainPage extends StatefulWidget {
  final int changeIndex;

  static const routeName = "MainPage";
  const MainPage({super.key, required this.changeIndex});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex = widget.changeIndex;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get widgetOptions {
    return [
      HomePage(
        scaffoldKey: scaffoldKey,
        onChangePage: (index) => onItemTapped(index),
      ),
      GerPage(),
      AddGerPage(),

      OrderPage(),
      DashboardPage(),
    ];
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(
      context,
    );
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        // statusBarColor: Colors.white,
        // statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: primary,
        statusBarBrightness: Brightness.light,
        // systemNavigationBarDividerColor:
      ),
    );
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: scaffoldKey,
        drawer: CustomDrawer(),
        extendBodyBehindAppBar: true,
        body: Center(child: widgetOptions.elementAt(_selectedIndex)),
        backgroundColor: white,
        extendBody: true,
        bottomNavigationBar: !isKeyboardVisible
            ? Container(
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),

                padding: EdgeInsets.only(
                  top: 8,
                  bottom: Platform.isIOS
                      ? mediaQuery.padding.bottom
                      : mediaQuery.padding.bottom + 16,
                  right: 8,
                  left: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavItem(
                      selectedIconPath: 'assets/svg/home_selected.svg',
                      unselectedIconPath: 'assets/svg/home_unselected.svg',
                      index: 0,
                      selectedIndex: _selectedIndex,
                      onTap: onItemTapped,
                      label: translateKey.translate('home'),
                    ),
                    SizedBox(width: 4),
                    _buildNavItem(
                      selectedIconPath: 'assets/svg/ger_selected.svg',
                      unselectedIconPath: 'assets/svg/ger_unselected.svg',
                      index: 1,
                      selectedIndex: _selectedIndex,
                      onTap: onItemTapped,
                      label: translateKey.translate('ger'),
                    ),
                    SizedBox(width: 4),
                    _buildNavItem(
                      selectedIconPath: 'assets/svg/addger_unselected.svg',
                      unselectedIconPath: 'assets/svg/addger_unselected.svg',
                      index: 2,
                      selectedIndex: _selectedIndex,
                      onTap: (index) {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          isDismissible: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return CreateCamp();
                          },
                        );
                      },
                      label: translateKey.translate('create_listing'),
                    ),
                    SizedBox(width: 4),
                    _buildNavItem(
                      selectedIconPath: 'assets/svg/order_selected.svg',
                      unselectedIconPath: 'assets/svg/order_unselected.svg',
                      index: 3,
                      selectedIndex: _selectedIndex,
                      onTap: onItemTapped,
                      label:
                          '${translateKey.translate('order')[0].toUpperCase()}${translateKey.translate('order').substring(1)}',
                    ),
                    SizedBox(width: 4),
                    _buildNavItem(
                      selectedIconPath: 'assets/svg/dashboard_selected.svg',
                      unselectedIconPath: 'assets/svg/dashboard_unselected.svg',
                      index: 4,
                      selectedIndex: _selectedIndex,
                      onTap: onItemTapped,
                      label: translateKey.translate('dashboard'),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}

Widget _buildNavItem({
  required String selectedIconPath,
  required String unselectedIconPath,
  required int index,
  required int selectedIndex,
  required Function(int) onTap,
  required String label,
}) {
  return Expanded(
    child: InkWell(
      onTap: () => onTap(index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selectedIndex == index ? white : primary,
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              selectedIndex == index ? selectedIconPath : unselectedIconPath,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: selectedIndex == index ? primary : white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
