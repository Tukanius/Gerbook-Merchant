import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/localization/localization_local.dart';
import 'package:provider/provider.dart';

class ChangeLanguagePage extends StatefulWidget {
  static const routeName = "ChangeLanguagePage";
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage>
    with AfterLayoutMixin {
  String _selectedLanguage = '';

  void _onLanguageSelected(String language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  String? local;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    local = await getLocale();
    setState(() {
      _selectedLanguage = local!;
    });
    print(_selectedLanguage);
  }

  // Currency currency = Currency();
  bool isLoading = false;
  onSave() async {
    final localizationProvider = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    );

    setState(() {
      isLoading = true;
    });
    try {
      await saveLocale("$_selectedLanguage");
      var res = await getLocale();
      print(res);
      await localizationProvider.loadTranslations('${res}');
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop(true);
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.of(context).pop();
        }
      },
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          elevation: 0.3,
          centerTitle: true,
          leading: GestureDetector(
            onTap: isLoading == true
                ? () {}
                : () {
                    Navigator.of(context).pop();
                  },
            child: Row(
              children: [
                SizedBox(width: 16),
                SvgPicture.asset('assets/svg/chevron_left.svg'),
              ],
            ),
          ),
          title: Text(
            localizationProvider.translate('change_language'),
            style: TextStyle(
              color: gray800,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        backgroundColor: white,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _languageOption(
                    label: localizationProvider.translate('mongolia'),
                    iconPath: 'assets/svg/mn.svg',
                    value: 'mn',
                  ),
                  SizedBox(height: 10),
                  _languageOption(
                    label: localizationProvider.translate('english'),
                    iconPath: 'assets/svg/uk.svg',
                    value: 'en',
                  ),
                  SizedBox(height: 10),
                  _languageOption(
                    label: localizationProvider.translate('chinese'),
                    iconPath: 'assets/svg/china.svg',
                    value: 'zh',
                  ),
                  SizedBox(height: 10),
                  _languageOption(
                    label: localizationProvider.translate('korean'),
                    iconPath: 'assets/svg/korea.svg',
                    value: 'ko',
                  ),
                  SizedBox(height: 10),
                  _languageOption(
                    label: localizationProvider.translate('japan'),
                    iconPath: 'assets/svg/jpn.svg',
                    value: 'ja',
                  ),
                  SizedBox(height: 10),
                  _languageOption(
                    label: localizationProvider.translate('russia'),
                    iconPath: 'assets/svg/circle_ru.svg',
                    value: 'ru',
                  ),
                  SizedBox(height: 10),
                  _languageOption(
                    label: localizationProvider.translate('german'),
                    iconPath: 'assets/svg/circle_german.svg',
                    value: 'de',
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: isLoading == true
                        ? () {}
                        : () async {
                            await onSave();
                          },
                    child: Container(
                      height: 47,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: primary,
                      ),
                      child: Center(
                        child: isLoading == true
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: white,
                                  strokeWidth: 1,
                                ),
                              )
                            : Text(
                                localizationProvider.translate('save'),
                                style: TextStyle(
                                  color: white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 22),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _languageOption({
    required String label,
    required String iconPath,
    required String value,
  }) {
    final isSelected = _selectedLanguage == value;
    return GestureDetector(
      onTap: isLoading == true ? () {} : () => _onLanguageSelected(value),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? primary : gray200),
          color: white,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(iconPath, width: 32, height: 24),
                SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            if (isSelected) SvgPicture.asset('assets/svg/checkbox.svg'),
          ],
        ),
      ),
    );
  }
}
