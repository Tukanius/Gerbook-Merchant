import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:merchant_gerbook_flutter/components/custom_comps/order_card.dart';
import 'package:merchant_gerbook_flutter/components/ui/color.dart';
import 'package:merchant_gerbook_flutter/components/ui/form_textfield.dart';
import 'package:merchant_gerbook_flutter/provider/localization_provider.dart';
import 'package:provider/provider.dart';

class GerPage extends StatefulWidget {
  const GerPage({super.key});

  @override
  State<GerPage> createState() => _GerPageState();
}

class _GerPageState extends State<GerPage> {
  ScrollController scrollController = ScrollController();
  final items = List.generate(400, (index) => '$index');
  int filterIndex = 0;
  TextEditingController searchController = TextEditingController();
  final List<String> tabs = [
    'Бүгд',
    'Хүлээгдэж байгаа',
    'Төлбөр төлөгдсөн',
    'Цуцлагдсан',
  ];
  final Map<String, String> tabFilters = {
    'Бүгд': "",
    'Хүлээгдэж байгаа': "NEW",
    'Төлбөр төлөгдсөн': "PENDING",
    'Цуцлагдсан': "DONE",
  };

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final translateKey = Provider.of<LocalizationProvider>(context);

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        title: Text(
          '${translateKey.translate('order')[0].toUpperCase()}${translateKey.translate('order').substring(1)}',
          style: TextStyle(
            color: gray800,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(24),
          child: Container(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: List.generate(tabs.length, (index) {
                        final bool isSelected = filterIndex == index;
                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              filterIndex = index;
                            });
                            final selectedTab = tabs[filterIndex];
                            final filter = tabFilters[selectedTab];
                            scrollController.animateTo(
                              scrollController.position.minScrollExtent,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeOut,
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: isSelected ? primary : white,
                              border: Border.all(
                                color: isSelected ? primary : gray200,
                              ),
                            ),
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                color: isSelected ? white : gray800,
                                fontFamily: 'Lato',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
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
                        SvgPicture.asset('assets/svg/search.svg', height: 20),
                        SizedBox(width: 8),
                      ],
                    ),
                    hintText:
                        "${translateKey.translate('ger')} ${translateKey.translate('search').toLowerCase()}",
                    hintTextColor: gray500,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 12),
                Container(
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
                        child: SvgPicture.asset('assets/svg/calendar.svg'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),

              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [1, 2, 3, 4, 5]
                          .map(
                            (item) => Column(
                              children: [
                                OrderCard(),
                                SizedBox(height: 12),
                                OrderCard(),
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
        ],
      ),
    );
  }
}
