import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/api/product_api.dart';
import 'package:merchant_gerbook_flutter/components/controller/refresher.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/ger_card%20list.dart';
import 'package:merchant_gerbook_flutter/components/custom_loader/custom_loader.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/models/result.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GerPage extends StatefulWidget {
  const GerPage({super.key});

  @override
  State<GerPage> createState() => _GerPageState();
}

class _GerPageState extends State<GerPage> with AfterLayoutMixin {
  ScrollController scrollController = ScrollController();
  bool filter = false;
  TextEditingController searchController = TextEditingController();
  Result myGers = Result();
  int page = 1;
  int limit = 10;
  bool isLoadingMyGer = true;
  bool isLoadingPage = true;
  Timer? timer;

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    try {
      await listOfMyGers(page, limit);

      setState(() {
        isLoadingPage = false;
      });
    } catch (e) {
      setState(() {
        isLoadingPage = true;
      });
    }
  }

  listOfMyGers(page, limit, {String? query}) async {
    myGers = await ProductApi().getmyGers(
      ResultArguments(page: page, limit: limit, query: query),
    );
    setState(() {
      isLoadingMyGer = false;
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
    await listOfMyGers(page, limit);
    refreshController.refreshCompleted();
  }

  onLoading() async {
    if (!mounted) return;
    setState(() {
      limit += 10;
    });
    await listOfMyGers(page, limit);
    refreshController.loadComplete();
  }

  onChange(String query) {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () async {
      listOfMyGers(page, limit, query: query);
      // setState(() {
      //   isLoadingStays = false;
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          shape: Border(bottom: BorderSide(color: gray200, width: 2)),
          elevation: 0,
          centerTitle: false,
          backgroundColor: white,
          automaticallyImplyLeading: false,
          title: Text(
            '${translateKey.translate('my_ger')[0].toUpperCase()}${translateKey.translate('my_ger').substring(1)}',
            style: TextStyle(
              color: gray800,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                print('==testset==');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 14,
                      top: 8,
                      bottom: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: gray300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          translateKey.translate('create_listing'),
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: gray700,
                          ),
                        ),
                        SizedBox(width: 8),
                        SvgPicture.asset('assets/svg/plus.svg'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
          ],
        ),
        body: isLoadingPage == true
            ? CustomLoader()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: FormTextField(
                            inputType: TextInputType.text,
                            controller: searchController,
                            colortext: black,
                            name: 'userName',
                            color: white,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 10),
                                SvgPicture.asset(
                                  'assets/svg/search.svg',
                                  height: 20,
                                ),
                                SizedBox(width: 8),
                              ],
                            ),
                            hintText:
                                "${translateKey.translate('ger')} ${translateKey.translate('search').toLowerCase()}",
                            hintTextColor: gray500,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            onChanged: (value) {
                              onChange(value);
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            print('Working');
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: white,
                              border: Border.all(color: gray300),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    'assets/svg/calendar.svg',
                                  ),
                                ),
                                filter == true
                                    ? Positioned(
                                        top: 3,
                                        right: 3,
                                        child: Container(
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                            border: Border.all(
                                              color: white,
                                              width: 2,
                                              strokeAlign:
                                                  BorderSide.strokeAlignInside,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Refresher(
                      refreshController: refreshController,
                      onLoading: onLoading,
                      onRefresh: onRefresh,
                      color: primary,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isLoadingMyGer == true
                                  ? CustomLoader()
                                  : myGers.rows?.isEmpty == true
                                  ? Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/empty_note.svg',
                                          width: 152,
                                        ),
                                        SizedBox(height: 16),
                                        Column(
                                          children: [
                                            Text(
                                              translateKey.translate('no_ger'),
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: gray900,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              translateKey.translate(
                                                'no_ger_please_add',
                                              ),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: gray600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 24),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 12,
                                            right: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            color: primary,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                color: white,
                                                size: 20,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                translateKey.translate(
                                                  'create_listing',
                                                ),
                                                style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              mediaQuery.padding.bottom + 24,
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: myGers.rows!
                                          .map(
                                            (item) => Column(
                                              children: [
                                                GerCardList(data: item),
                                                SizedBox(height: 12),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ),
                              SizedBox(height: mediaQuery.padding.bottom + 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
