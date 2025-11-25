import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:merchant_gerbook_flutter/api/auth_api.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/models/user.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/profile_page/settings_page/deactivate_bottom_sheet.dart';
import 'package:merchant_gerbook_flutter/src/profile_page/settings_page/edit_password.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = "SettingsPage";

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool loadActivate = false;
  User deactivateUser = User();

  onDeactivate() async {
    try {
      setState(() {
        loadActivate = true;
      });
      deactivateUser = await AuthApi().accountDeactivate();
      setState(() {
        loadActivate = false;
      });
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        backgroundColor: transparent,
        builder: (context) {
          return DeactivateBottomSheet(deactivate: deactivateUser);
        },
      );
      // Navigator.of(context).pushNamed(SplashPage.routeName);
      // showSuccess(context, 'Your account has been successfully deactivated.');
      // print(res);
    } catch (e) {
      print(e);
      setState(() {
        loadActivate = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: gray200, width: 2)),
        toolbarHeight: 56,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),

              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: SvgPicture.asset(
                  'assets/svg/chevron_left.svg',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          translateKey.translate('settings'),
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: gray800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translateKey.translate('password'),
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: gray900,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        translateKey.translate('last_changed_6_months_ago'),
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: gray600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: () async {
                      final value = await showModalBottomSheet(
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
                          return EditPassword();
                        },
                      );
                      if (value == true) {
                        // callUser();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        translateKey.translate('zasah'),
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Container(
                width: mediaQuery.size.width,
                height: 1,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: gray200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(320),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translateKey.translate('deactive_account'),

                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: gray900,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          translateKey.translate(
                            'you_can_delete_your__6c67bfc5',
                          ),
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: gray600,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  GestureDetector(
                    onTap: loadActivate == true
                        ? () {}
                        : () {
                            onDeactivate();
                          },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: loadActivate == true
                          ? CustomLoader(loadColor: primary)
                          : Text(
                              translateKey.translate('zasah'),
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: primary,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
model create 
api create 
get data 
 */