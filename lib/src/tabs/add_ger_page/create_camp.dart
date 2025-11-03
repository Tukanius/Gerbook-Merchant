import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/cards/camp_card.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/models/result.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:merchant_gerbook_flutter/src/tabs/add_ger_page/create_camp_comps/create_camp_data.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CreateCamp extends StatefulWidget {
  const CreateCamp({super.key});

  @override
  State<CreateCamp> createState() => _CreateCampState();
}

class _CreateCampState extends State<CreateCamp> with AfterLayoutMixin {
  TextEditingController searchController = TextEditingController();
  Timer? timer;
  bool isLoadingCamp = true;
  Result campList = Result();
  bool isLoadingPage = true;
  int page = 1;
  int limit = 10;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      await listOfCamps(page, limit);
      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
    print('======');
    print(isLoadingPage);
    print('======');
  }

  listOfCamps(page, limit, {String? query}) async {
    campList = await ProductApi().getCampList(
      ResultArguments(page: page, limit: limit, query: query),
    );
    setState(() {
      isLoadingCamp = false;
    });
  }

  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      limit = 10;
    });
    await listOfCamps(page, limit, query: searchController.text);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    if (!mounted) return;
    setState(() {
      limit += 10;
    });
    await listOfCamps(page, limit, query: searchController.text);
    refreshController.loadComplete();
  }

  onChange(String query) async {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      await listOfCamps(page, limit, query: searchController.text);
      setState(() {
        isLoadingCamp = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Container(
      height: mediaQuery.size.height * 0.9,
      width: mediaQuery.size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: white,
      ),
      child: isLoadingPage == true
          ? CustomLoader()
          : Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6),
                    Center(
                      child: Container(
                        width: 48,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: gray800,
                        ),
                      ),
                    ),
                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Text(
                        translateKey.translate('choose_camp'),
                        style: TextStyle(
                          color: gray900,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: FormTextField(
                        inputType: TextInputType.text,
                        controller: searchController,
                        colortext: black,
                        name: 'userName',
                        color: white,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        onChanged: (query) {
                          onChange(query);
                        },
                        borderRadius: 100,
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 12),
                            SvgPicture.asset(
                              'assets/svg/search.svg',
                              height: 24,
                              width: 24,
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                        hintText: "${translateKey.translate('search_camp')}",
                        hintTextColor: gray500,
                      ),
                    ),
                    SizedBox(height: 14),
                    isLoadingCamp == true
                        ? CustomLoader()
                        : campList.rows?.isEmpty == true
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 32),
                                  SvgPicture.asset(
                                    'assets/svg/empty_box.svg',
                                    width: 141,
                                  ),
                                  SizedBox(height: 12),
                                  Column(
                                    children: [
                                      Text(
                                        translateKey.translate('no_camp_data'),
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: gray900,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Text(
                                          translateKey.translate(
                                            'no_camp_create_camp',
                                          ),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Lato',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: gray600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).popAndPushNamed(
                                        CreateCampData.routeName,
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: gray300),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        translateKey.translate('create_camp'),
                                        style: TextStyle(
                                          color: gray700,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Column(
                                  children: campList.rows!
                                      .map(
                                        (data) => Column(
                                          children: [
                                            CampCard(data: data),
                                            SizedBox(height: 8),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: white,
                    padding: EdgeInsets.only(
                      bottom: Platform.isIOS
                          ? MediaQuery.of(context).padding.bottom
                          : 16,
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(
                              context,
                            ).popAndPushNamed(CreateCampData.routeName);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: white,
                              border: Border.all(color: gray300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  translateKey.translate('create_camp'),
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
